# helm-eks-action
Github Action for  executing Helm commands on EKS (using aws-iam-authenticator).

The Helm version installed is Helm3.

This action was inspired by [kubernetes-action](https://github.com/Jberlinsky/kubernetes-action).

# Instructions

This Github Action was created with EKS in mind, therefore the following example refers to it.

## Input variables

1. `plugins`: you can specify a list of Helm plugins you'd like to install and use later on in your command. eg. helm-secrets or helm-diff. This action does not support only a specific list of Helm plugins, rather any Helm plugin as long as you supply its URL. You can use the following [example](#example) as a reference.
2. `command`: your kubectl/helm command. This supports multiline as per the Github Actions workflow syntax.

example for multiline:
```yaml
...
with:
  command: |
    helm upgrade --install my-release chart/repo
    kubectl get pods
```

## Example

```yaml
name: deploy

on:
    push:
        branches:
            - master
            - develop

jobs:
  deploy:
    runs-on: ubuntu-latest
    env:
      AWS_REGION: us-east-1
      CLUSTER_NAME: my-staging
    steps:
      - uses: actions/checkout@v2

      - name: AWS Credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          role-to-assume: arn:aws:iam::<your account id>:role/github-actions
          role-session-name: ci-run-${{ github.run_id }}
          aws-region: ${{ env.AWS_REGION }}
      
      - name: kubeconfing
        run: aws eks update-kubeconfig --name ${{ env.CLUSTER_NAME }} --region ${{ env.AWS_REGION }}

      - name: helm deploy
        uses: koslib/helm-eks-action@master
        with:
          plugins: "https://github.com/jkroepke/helm-secrets" # optional
          command: helm secrets upgrade <release name> --install --wait <chart> -f <path to values.yaml>
```

# Response

Use the output of your command in later steps

```yaml
    steps:
      - name: Get URL
        id: url
        uses: koslib/helm-eks-action@master
        env:
          KUBE_CONFIG_DATA: ${{ secrets.KUBE_CONFIG_DATA }}
        with:
          command: kubectl get svc my_svc -o json | jq -r '.status.loadBalancer.ingress[0].hostname'

      - name: Print Response
        run: echo "Response was ${{ steps.url.outputs.response }}"

```

# Accessing your cluster

> Breaking change from v2.x and onwards

From version v2.x and onwards, this action does not require any kube-config data set as a secret to connect to the repo. Instead, by authenticating with your AWS account, it automatically generates a kube-config file for your cluster which is then used to execute any `helm` commands.


# Contributions

Pull requests, issues or feedback of any kind are more than welcome by anyone!

If this action has helped you in any way and enjoyed it, feel free to submit feedback through [issues](https://github.com/koslib/helm-eks-action/issues) or buy me a coffee!

<a href="https://www.buymeacoffee.com/koslib" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
