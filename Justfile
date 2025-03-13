up:
    nix flake update
    git add flake.lock
    git commit -m "flake update"

# nixos

cp:
    rm -rf /etc/nixos/*
    cp -r ./* /etc/nixos
    rm -rf /etc/nixos/.git

cl:
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
    sudo nix-collect-garbage --delete-old
    nix-collect-garbage --delete-old

bd host:
    sudo nixos-rebuild switch --flake .#{{host}}

tt host:
    sudo nixos-rebuild test --flake .#{{host}}

bdg host:
    git add *
    git commit -m "update"
    sudo nixos-rebuild switch --flake .#{{host}}

ttg host:
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

htt host:
    home-manager test --flake .#{{host}}

hbdg host:
    git add *
    git commit -m "update"
    home-manager switch --flake .#{{host}}

httg host:
    git add *
    git commit -m "update"
    home-manager test --flake .#{{host}}

# system manager
# 必须使用root用户运行(不是root权限！)
# sudo似乎会导致所有软件源(包括官方源)失效，导致所有软件包都必须从github拉取源码编译

ism host:
    nix run 'github:numtide/system-manager' -- switch --flake '.#{{host}}'

sbd host:
    system-manager switch --flake .#{{host}}

stt host:
    system-manager test --flake .#{{host}}

sbdg host:
    git add *
    git commit -m "update"
    system-manager switch --flake .#{{host}}

sttg host:
    git add *
    git commit -m "update"
    system-manager test --flake .#{{host}}
