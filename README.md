# 🪴 Kubegarden

	⁠A lightweight, local Kubernetes development playground using k3d, kind or talos.

Kubegarden is a developer-friendly environment designed for quick and easy setup of local Kubernetes clusters. It integrates popular tools like ArgoCD, Ingress-NGINX, and more to provide a seamless platform for testing Kubernetes configurations and deploying cloud-native applications.


## Project's Directory Structure

This section gives a small introduction into the exact directory structure of this project, as it is of importance.

All applications are deployed by ArgoCD.
This GitHub project is configured as a Git generator in ArgoCD's [`ApplicationSet`](https://argo-cd.readthedocs.io/en/stable/operator-manual/applicationset/).
Here, [we use directory path segments](./argocd/dev/<k3d,kind,talos>/argocd/appsets/appset.yaml) as values for the application deployment, namely:

```
<application name>/<environment>/<cluster to deploy to>/<Kubernetes namespace>/
```

## Dev Container

This project includes a [Dev Container](https://containers.dev/) with the following features:

### Features

- Local cluster orchestration via [k3d](https://k3d.io/), [kind](https://kind.sigs.k8s.io/) or [talos](https://www.talos.dev/)
- GitOps-ready with [ArgoCD](https://argo-cd.readthedocs.io/)
- Ingress support using NGINX Ingress Controller
- Easily customizable with Taskfile automation
- ⁠Plug-and-play environment for Kubernetes experimentation

For the DevContainer to run, there are a few requisites:

- [Docker](https://docs.docker.com/desktop/install/linux-install/) must be installed
- [VSCode](https://code.visualstudio.com/download) must be installed -- VSCode will not install extensions by Microsoft
- Install the [Dev Containers VSCode extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- Open this project in VSCode and when asked whether to start the dev container, acknowledge
- To follow the progress, you can click the notification 'Starting Dev Container (show log)'
- Now copy the `.env.example` file and configure the `.env` file in this project, and put in there:
  ```sh
    ## GLOBAL
    CLUSTER_TYPE=k3d      # There are 3 options. k3d, kind or talos
    SKIP_DEPLOY=false     # Set to `true` if you only want to deploy the minimal components the run Kubernetes

    ## GITHUB/GITLAB CREDENTIALS
    USERNAME=
    PERSONAL_ACCESS_TOKEN=

    ## CILIUM
    CILIUM_VERSION=1.17.4

    ## TALOS
    TALOS_HA=false        # Set to `true` of you want to deploy 3 Talos nodes
    K8S_VERSION=1.30.4    # Which version of Kubernetes you want to install

    ### ARGOCD
    ARGOCD_REPO_URL=https://github.com/ktijssen/kubegarden.git
    ARGOCD_BOOTSTRAP_DIR=argocd/dev/$CLUSTER_TYPE/argocd
    ARGOCD_APPSET_NAME=infra-apps
  ```

### Running the local development environment

These steps are only needed when you are about to run the infrastructure development environment:

- Open a new terminal inside the DevContainer, using the VSCode 'terminal' panel and type:
  ```sh
  task up
  ```
  This task will create a Kubernetes cluster.
  ArgoCD will be bootstrapped on this cluster.

- From your host system's browser, you can now visit:
  - https://argocd.localhost


## Task Overview

| Task Name       | Description                                                                 |
|----------------|-----------------------------------------------------------------------------|
| `up`           | Deploys the entire local development environment.                           |
| `destroy`      | Destroys the entire local development environment.                          |
| `switch`       | Switches the branch that the management ApplicationSet tracks in Git.       |
| `sync-local`   | Watches local changes and applies them to the cluster.                      |
| `sync`         | Triggers a sync for one or more services.                                   |
| `sync-all`     | Triggers a sync for all services.                                           |
| `sync-profiles`| Syncs a predefined selection of applications.                               |
| `apply-local`  | Applies local changes once to the local cluster.                            |

To view all available tasks:
```bash
task --list
```
