# simple-pki

A simple tool for syncing a users GitHub SSH public keys to various remote machines `authorized_keys` config.

A simple, lightweight CLI tool to manage SSH authorized keys by syncing them with GitHub public keys. It allows you to grant SSH access to servers based on GitHub identities.

## Features

- **GitHub Integration**: Fetch public SSH keys directly from GitHub users (`github.com/username.keys`).
- **Automated Sync**: Optional cron job integration to keep keys up-to-date automatically.
- **Safety**: Backs up existing `authorized_keys` before overwriting.
- **Configurable**: Stores configuration in `~/.config/simple-pki/config.json`.

## Prerequisites

- `bash`
- `curl`
- `jq` (for JSON processing)

## Installation

To install `simple-pki` to your local user bin directory (`~/.local/bin`), run:

```bash
curl -sL https://raw.githubusercontent.com/nimish-ks/simple-pki/main/install.sh | bash
```

Make sure `~/.local/bin` is in your `$PATH`.

## Usage

### Interactive Setup

Run the tool interactively to set up users and sync keys:

```bash
simple-pki -u username1,username2
```

This will:
1. Verify the GitHub users exist.
2. Ask for confirmation.
3. Fetch their SSH keys.
4. Overwrite `~/.ssh/authorized_keys` with the fetched keys (creating a backup of the old one).
5. Optionally set up a cron job for auto-updates.

### Command Line Options

```text
Usage: simple-pki [OPTIONS]

Options:
  -u USERNAME(S)  GitHub username(s) to configure (comma separated)
  -d              Daemon mode (non-interactive update from config)
  -h              Show this help message
```

### Daemon Mode

The tool includes a daemon mode meant for cron jobs. It reads the saved configuration and updates keys without user interaction.

```bash
simple-pki -d
```

### Configuration

Configuration is stored in `~/.config/simple-pki/config.json`:

```json
{
  "version": "1.0.0",
  "usernames": [
    "nimish-ks",
    "octocat"
  ]
}
```

