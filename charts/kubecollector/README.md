# Lightspin KubeCollector

![Version: 0.1.12](https://img.shields.io/badge/Version-0.1.12-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.0.0](https://img.shields.io/badge/AppVersion-2.0.0-informational?style=flat-square)

[Lightspin](https://www.lightspin.io/) is a graph-based technology immediately visualizes, prioritizes, and dynamically remediates critical cloud risks with no custom configuration needed. This repository contains the Helm chart for the Lightspin KubeCollector application to be deployed on customers Kubernetes clusters.

## How to use Lightspin Helm repository

You need to add this repository to your Helm repositories:

```
helm repo add lightspin https://helm.lightspin.cloud
helm repo update
```

## Quick start

Lightspin KubeCollector runs in 4 Deployments and 1 DaemonSet for the runtime engine.

**Note:** if runtime is disabled only 3 Deployments are applied.

### Installing the Lightspin KubeCollector Chart

To install the chart with the release name `<RELEASE_NAME>`, retrieve your Lightspin API key from the Settings -> Accounts -> Kuberentes Cluster section in Lightspin platform and run:

```bash
helm install <RELEASE_NAME> \
    --namespace lightspin --create-namespace \
    --set apiKey=<LIGHTSPIN_API_KEY>,tenantId=<YOUR_TENANT_ID>,clusterName=<YOUR_CLUSTER_NAME> lightspin/kubecollector
```

By default, this Chart creates a Secret and puts an API key in that Secret.
However, you can use manually created secrets by setting the `apiKeyExistingSecret` value pointing to the secret name.

**Note:** When creating the secret, be sure to name the key field `API_KEY`

After a few minutes, you should see a the cluster added to the accounts section in the settings page and that a scan has started.

**Note:** Non US platform customers can set the <LIGHTSPIN_API_URL> using the `apiUrl` field.

```bash
helm install <RELEASE_NAME> \
    --set apiKey=<LIGHTSPIN_API_KEY> \
    --set apiUrl=<LIGHTSPIN_API_URL> \
    --set tenantId=<YOUR_TENANT_ID> \
    --set clusterName=<YOUR_CLUSTER_NAME> \
    --namespace lightspin --create-namespace \
    lightspin/light-kubecollector
```

### Upgrading

#### From 1.x to 2.x

⚠️ Migrating from 1.x to 2.x requires a manual action.

The `Lightspin KubeCollector` chart has been refactored.
Please uninstall the previous version of the chart and install the new one.

```bash
helm uninstall <RELEASE_NAME> --namespace lightspin
```

### Uninstalling the Chart

To uninstall/delete the `<RELEASE_NAME>` deployment:

```bash
helm delete <RELEASE_NAME> --purge --namespace lightspin
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

As a best practice, a YAML file that specifies the values for the chart parameters should be used to configure the chart. Any parameters not specified in this file will default to those set in [values.yaml](values.yaml).

1. Create an empty `kubecollector-values.yaml` file.
2. Set the parameters you would like to override in your `kubecollector-values.yaml`.
3. Install or upgrade the Lightspin KubeCollector Helm chart with the new `kubecollector-values.yaml` file:

```bash
helm install -f kubecollector-values.yaml <RELEASE_NAME> --namespace lightspin --create-namespace lightspin/kubecollector
```

OR

```bash
helm upgrade -f kubecollector-values.yaml <RELEASE_NAME> --namespace lightspin --create-namespace lightspin/kubecollector
```

## All configuration options

The following table lists the configurable parameters of the Lightspin KubeCollector chart and their default values. Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| apiKey | string | `nil` | Lightspin API key |
| apiKeyExistingSecret | string | `nil` | Use existing Secret which stores API key instead of creating a new one. The value should be set with the `API_KEY` key inside the secret. |
| apiUrl | string | `"https://k8sapi.lightspin.cloud"` | Lightspin API URL (override for non US customers) |
| beat.affinity | object | `{}` | By default, Cluster Agent Deployment Pods are forced to run on different Nodes. |
| beat.fullnameOverride | string | `"light-kubecollector-beat"` | fully qualified name of the beat service |
| beat.image.pullPolicy | string | `"Always"` | kubecollector beat docker image pullPolicy |
| beat.image.repository | string | `"public.ecr.aws/k7e6s3l5/light-kubecollector"` | kubecollector image repository |
| beat.image.tag | string | `"latest"` | kubecollector beat image tag |
| beat.name | string | `"beat"` | name of the beat service |
| beat.nodeSelector | object | `{}` | Allow the kubecollector beat Deployment to schedule on selected nodes |
| beat.podAnnotations | object | `{}` | Annotations to add to the kubecollector beat pod |
| beat.podPriorityClassName | string | `nil` | Set pod priorityClassName |
| beat.replicaCount | int | `1` | Specify the number of replicas for the beat service |
| beat.resources | object | `{"limits":{"cpu":"300m","memory":"200Mi"},"requests":{"cpu":"100m","memory":"100Mi"}}` | kubecollector beat resource requests and limits. |
| beat.tolerations | list | `[]` | Allow the kubecollector beat to schedule on tainted nodes |
| broker.affinity | object | `{}` | By default, Cluster Agent Deployment Pods are forced to run on different Nodes. |
| broker.config.port | int | `6379` | kubecollector broker listening port. |
| broker.fullnameOverride | string | `"light-kubecollector-broker"` | fully qualified name of the broker service |
| broker.image.pullPolicy | string | `"IfNotPresent"` | redis docker image pullPolicy |
| broker.image.repository | string | `"redis"` | redis docker image repository |
| broker.image.tag | string | `"7.0.5"` | redis docker image tag |
| broker.name | string | `"broker"` | name of the broker service component |
| broker.nodeSelector | object | `{}` | Allow the kubecollector broker Deployment to schedule on selected nodes |
| broker.podAnnotations | object | `{}` | Annotations to add to the kubecollector broker pod |
| broker.podPriorityClassName | string | `nil` | Set pod priorityClassName |
| broker.replicaCount | int | `1` | Specify the number of replicas for the broker service |
| broker.resources | object | `{"limits":{"cpu":1,"memory":"600Mi"},"requests":{"cpu":"300m","memory":"300Mi"}}` | kubecollector broker resource requests and limits. |
| broker.tolerations | list | `[]` | Allow the kubecollector broker to schedule on tainted nodes |
| clusterId | string | `""` | Your kubernetes cluster unique identifier (uuid4). will be derived from kube-system namespace uid. |
| clusterName | string | `nil` | Your kubernetes cluster name to be identified in Lightspin platform. |
| commonLabels | object | `{}` | Labels to apply to all resources |
| fullnameOverride | string | `nil` | Override the full qualified app name |
| nameOverride | string | `nil` | Override name of app |
| namespace.forceNamespace | string | `nil` | Override namespace of app |
| runtime.enabled | bool | `true` | enable runtime detection services. |
| runtime.events.affinity | object | `{}` | By default, Cluster Agent Deployment Pods are forced to run on different Nodes. |
| runtime.events.config.log_level | string | `"INFO"` | logs severity level. |
| runtime.events.fullnameOverride | string | `"light-kuberuntime-events"` | fully qualified name of the runtime events service |
| runtime.events.image.repository | string | `"public.ecr.aws/k7e6s3l5/light-kuberuntime"` | kuberuntime events image repository |
| runtime.events.image.tag | string | `"latest"` | kuberuntime events image tag |
| runtime.events.name | string | `"events"` | name of the runtime events service |
| runtime.events.nodeSelector | object | `{}` | Allow the runtime events Deployment to schedule on selected nodes |
| runtime.events.podAnnotations | object | `{}` | Annotations to add to the runtime events pod |
| runtime.events.podPriorityClassName | string | `nil` | Set pod priorityClassName |
| runtime.events.tolerations | list | `[]` | Allow the runtime events to schedule on tainted nodes |
| runtime.falco.affinity | object | `{}` | By default, Cluster Agent Deployment Pods are forced to run on different Nodes. |
| runtime.falco.ebpf_probe.enabled | bool | `false` | enable ebpf probe for falco. |
| runtime.falco.fullnameOverride | string | `"lightspin-runtime"` | fully qualified name of the falco daemonset service |
| runtime.falco.image.repository | string | `"public.ecr.aws/falcosecurity/falco"` | falco agent image repository |
| runtime.falco.image.tag | string | `"0.33.1"` | falco agent image tag |
| runtime.falco.name | string | `"runtime"` | name of the falco daemonset service |
| runtime.falco.nodeSelector | object | `{}` | Allow the falco Daemonset to schedule on selected nodes |
| runtime.falco.podAnnotations | object | `{}` | Annotations to add to the falco Daemonset pod |
| runtime.falco.podPriorityClassName | string | `nil` | Set pod priorityClassName |
| runtime.falco.tolerations | list | `[{"effect":"NoSchedule","key":"node-role.kubernetes.io/master"}]` | Allow the falco Daemonset to schedule on tainted nodes |
| tenantId | string | `nil` | Lightspin tenant id (id-xyz). |
| worker.affinity | object | `{}` | By default, Cluster Agent Deployment Pods are forced to run on different Nodes. |
| worker.config.api_rate_limit | float | `0` | kubernetes api calls sleep time between each call. |
| worker.config.cmd_poller_interval | int | `60` | check for command message interval. |
| worker.config.concurrency | int | `2` | number of concurrent tasks being executed. |
| worker.config.cron_schedule | string | `nil` | crontab format scan schedule (daily scan with current time will be used as default). |
| worker.config.keep_alive_interval | int | `900` | keep alive message interval. |
| worker.config.log_level | string | `"INFO"` | logs severity level. |
| worker.config.runtime_rules_update_interval | int | `86400` | runtime rules check for update interval. |
| worker.config.vuls_enabled | bool | `true` | enable vulnerability scanning. |
| worker.config.vuls_private_repo | bool | `true` | enable vulnerability scanning on private repository images (uses pull secret). |
| worker.fullnameOverride | string | `"light-kubecollector-worker"` | fully qualified name of the worker service |
| worker.image.pullPolicy | string | `"Always"` | kubecollector worker docker image pullPolicy |
| worker.image.repository | string | `"public.ecr.aws/k7e6s3l5/light-kubecollector"` | kubecollector image repository |
| worker.image.tag | string | `"latest"` | kubecollector worker image tag |
| worker.name | string | `"worker"` | name of the worker service |
| worker.nodeSelector | object | `{}` | Allow the kubecollector worker Deployment to schedule on selected nodes |
| worker.podAnnotations | object | `{}` | Annotations to add to the kubecollector worker pod |
| worker.podPriorityClassName | string | `nil` | Set pod priorityClassName |
| worker.replicaCount | int | `1` | Specify the number of replicas for the worker service |
| worker.resources | object | `{"limits":{"cpu":"300m","memory":"1024Mi"},"requests":{"cpu":"100m","memory":"300Mi"}}` | kubecollector worker resource requests and limits. |
| worker.tolerations | list | `[]` | Allow the kubecollector worker to schedule on tainted nodes |
