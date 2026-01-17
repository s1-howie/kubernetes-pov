# kubernetes-pov
A set of resources that can be used during POVs where kubernetes is involved.

Example YAML for testing KSPM and/or Admission Controller features

```yaml
{% include_relative manifests/sentinelone-pov.yaml %}
```

[View the manifest](manifests/sentinelone-pov.yaml)



### Apply the manifest

```bash
kubectl apply -f https://raw.githubusercontent.com/s1-howie/kubernetes-pov/main/manifests/sentinelone-pov.yaml

```