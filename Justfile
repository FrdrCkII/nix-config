up:
    nix flake update
    git add flake.lock
    git commit -m "update: flake"

# nixos

ncp:
    rm -rf /etc/nixos/*
    cp -r ./* /etc/nixos
    rm -rf /etc/nixos/.git

ncl:
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
    sudo nix-collect-garbage --delete-old
    nix-collect-garbage --delete-old

nbd host:
    sudo nixos-rebuild switch --flake .#{{host}}

nbdg host:
    git add *
    git commit -m "update"
    sudo nixos-rebuild switch --flake .#{{host}}

ntt host:
    sudo nixos-rebuild test --flake .#{{host}}

nttg host:
    git add *
    git commit -m "update"
    sudo nixos-rebuild test --flake .#{{host}}

# home manager

hcl:
    home-manager expire-generations '-1 days'
    sudo nix-collect-garbage --delete-old
    nix-collect-garbage --delete-old

ihm host:
    nix run 'github:nix-community/home-manager' -- switch --flake '.#{{host}}'

hbd host:
    home-manager switch --flake .#{{host}}

hbdg host:
    git add *
    git commit -m "update"
    home-manager switch --flake .#{{host}}

htt host:
    home-manager test --flake .#{{host}}

httg host:
    git add *
    git commit -m "update"
    home-manager test --flake .#{{host}}

# system manager

ism host:
    sudo nix run 'github:numtide/system-manager' -- switch --flake '.#{{host}}'

sbd host:
    sudo system-manager switch --flake .#{{host}}

sbdg host:
    git add *
    git commit -m "update"
    sudo system-manager switch --flake .#{{host}}

stt host:
    sudo system-manager test --flake .#{{host}}

sttg host:
    git add *
    git commit -m "update"
    sudo system-manager test --flake .#{{host}}
