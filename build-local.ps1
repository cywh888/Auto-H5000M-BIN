param(
    [switch]$InstallDeps,
    [switch]$PrepareOnly,
    [switch]$ConfigOnly,
    [switch]$SkipToolchain,
    [switch]$SkipDownload,
    [switch]$SkipFeedsUpdate,
    [switch]$CleanVolume,
    [int]$Threads = 4,
    [string]$DockerImage = 'ubuntu:22.04',
    [string]$DockerVolume = 'auto-h5000m-build'
)

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $repoRoot

function Require-Command {
    param([Parameter(Mandatory = $true)][string]$Name)
    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Missing required command: $Name"
    }
}

function Set-DefaultEnv {
    param([Parameter(Mandatory = $true)][string]$Name, [Parameter(Mandatory = $true)][string]$Value)
    if ([string]::IsNullOrWhiteSpace([Environment]::GetEnvironmentVariable($Name, 'Process'))) {
        [Environment]::SetEnvironmentVariable($Name, $Value, 'Process')
    }
}

Require-Command docker

Set-DefaultEnv ENABLE_ADGUARDHOME true
Set-DefaultEnv ENABLE_OPENCLASH true
Set-DefaultEnv ENABLE_NIKKI true
Set-DefaultEnv ENABLE_UPNP true
Set-DefaultEnv ENABLE_VLMCSD true
Set-DefaultEnv ENABLE_MOSDNS true
Set-DefaultEnv ENABLE_DOCKERMAN true
Set-DefaultEnv ENABLE_QMODEM_NEXT true
Set-DefaultEnv ENABLE_QMODEM false
Set-DefaultEnv ENABLE_MWAN true
Set-DefaultEnv ENABLE_HOMEPROXY true
Set-DefaultEnv ENABLE_ADBYBY_PLUS true
Set-DefaultEnv ENABLE_ORIGINAL_MODEM false
Set-DefaultEnv ENABLE_EASYMESH true
Set-DefaultEnv GOPROXY 'https://goproxy.cn,https://proxy.golang.org,direct'
Set-DefaultEnv GOSUMDB 'sum.golang.google.cn'
Set-DefaultEnv DOWNLOAD_MIRROR 'https://mirrors.tuna.tsinghua.edu.cn/openwrt/sources;https://mirrors.ustc.edu.cn/openwrt/sources;https://mirrors.bfsu.edu.cn/openwrt/sources'
Set-DefaultEnv GITHUB_PROXY_PREFIXES 'https://ghfast.top/ https://gh-proxy.com/ https://gh.llkk.cc/'

if ($CleanVolume) {
    Write-Host "Removing Docker volume: $DockerVolume"
    docker volume rm $DockerVolume 2>$null | Out-Null
}

$scriptArgs = @()
if ($InstallDeps)     { $scriptArgs += '--install-deps' }
if ($PrepareOnly)     { $scriptArgs += '--prepare-only' }
if ($ConfigOnly)      { $scriptArgs += '--config-only' }
if ($SkipToolchain)   { $scriptArgs += '--skip-toolchain' }
if ($SkipDownload)    { $scriptArgs += '--skip-download' }
if ($SkipFeedsUpdate) { $scriptArgs += '--skip-feeds-update' }

$dockerScriptArgs = ($scriptArgs | ForEach-Object { "'$_'" }) -join ' '

$envNames = @(
    'ENABLE_ADGUARDHOME','ENABLE_OPENCLASH','ENABLE_NIKKI','ENABLE_UPNP','ENABLE_VLMCSD',
    'ENABLE_MOSDNS','ENABLE_DOCKERMAN','ENABLE_QMODEM_NEXT','ENABLE_QMODEM','ENABLE_MWAN',
    'ENABLE_HOMEPROXY','ENABLE_ADBYBY_PLUS','ENABLE_ORIGINAL_MODEM','ENABLE_EASYMESH',
    'GOPROXY','GOSUMDB','DOWNLOAD_MIRROR','GITHUB_PROXY_PREFIXES',
    'HOMEPROXY_REPO_URL','HOMEPROXY_REPO_BRANCH','HOMEPROXY_FALLBACK_REPO_URL','HOMEPROXY_FALLBACK_REPO_BRANCH',
    'ADBYBY_PLUS_I18N_IPK_URL','ADGUARDHOME_I18N_IPK_URL',
    'REPO_URL','REPO_BRANCH','CONFIG_URL','SOURCE_DIR','ARTIFACTS_DIR'
)

$dockerEnv = @()
foreach ($name in $envNames) {
    $value = [Environment]::GetEnvironmentVariable($name, 'Process')
    if ($null -ne $value -and $value -ne '') {
        $dockerEnv += @('-e', $name)
    }
}
$dockerEnv += @('-e', "THREADS=$Threads", '-e', 'HEARTBEAT_INTERVAL=300', '-e', 'FORCE_UNSAFE_CONFIGURE=1')

$inner = @"
set -euo pipefail
apt-get update >/dev/null
DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential git ccache python3 python3-pip libncurses5-dev libncursesw5-dev libssl-dev libgmp3-dev libmbedtls-dev zlib1g-dev libelf-dev rustc cargo golang-go autoconf automake libtool patch make gcc g++ gawk gettext unzip file wget curl rsync zstd tar xz-utils bzip2 gzip perl bison flex pkg-config ca-certificates time >/dev/null
mkdir -p /work/repo
rsync -a --delete --exclude '/.git' --exclude '/immortalwrt' --exclude '/artifacts' --exclude '/artifacts.tar.gz' --exclude '/source.tar.gz' /src/ /work/repo/
cd /work/repo
bash scripts/local-build.sh $dockerScriptArgs
"@
$inner = $inner -replace "`r`n", "`n"

Write-Host "Starting H5000M local build in Docker volume '$DockerVolume'..."
docker run --rm --network host -v "${repoRoot}:/src:ro" -v "${DockerVolume}:/work" @dockerEnv $DockerImage bash -lc $inner

if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

if ($PrepareOnly -or $ConfigOnly) {
    Write-Host "`nPreparation/configuration completed. Firmware artifacts were not refreshed because the build stopped before compilation."
    exit 0
}

Write-Host "Copying artifacts back to workspace..."
$copyInner = 'set -e; rm -rf /out/artifacts /out/artifacts.tar.gz; cp -a /work/repo/artifacts /out/artifacts; cp -f /work/repo/artifacts.tar.gz /out/artifacts.tar.gz'
docker run --rm -v "${DockerVolume}:/work" -v "${repoRoot}:/out" $DockerImage bash -lc $copyInner
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

Write-Host "`nFirmware artifacts:"
Get-ChildItem -LiteralPath (Join-Path $repoRoot 'artifacts') -File | Sort-Object Name | Format-Table Name,Length,LastWriteTime -AutoSize

$manifest = Join-Path $repoRoot 'artifacts\openwrt-image.manifest'
if (Test-Path -LiteralPath $manifest) {
    Write-Host "`nKey packages in image manifest:"
    Select-String -Path $manifest -Pattern '^(luci-i18n-adbyby-plus-zh-cn|luci-i18n-adguardhome-zh-cn|luci-app-homeproxy|mesh11sd|wpad-mesh-openssl|luci-app-mtwifi-cfg|luci-i18n-mtwifi-cfg-zh-cn|kmod-mt_wifi7|kmod-mt_hwifi|kmod-mt7992|kmod-mt799a|v2ray-geoip|v2ray-geosite) ' | ForEach-Object { $_.Line }
}

Write-Host "`nArchive: artifacts.tar.gz"