url do repositório do componente: https://github.com/openstack/openstack-helm/tree/master/heat

construindo os arquivos e separando os componentes k8s:
1. cria um values padrão do projeto: https://github.com/openstack/openstack-helm/blob/master/heat/values.yaml
2. cria template helm template openstack-keystone openstack-helm/keystone --namespace openstack --version 0.3.12 --values values.yaml > keystone.yaml
3. cria os yamls dos recursos: kubectl-slice --input-file=keystone.yaml --output-dir=out --template "{{.kind | lower}}/{{.metadata.name}}.{{.kind | lower}}.yaml"


Os valores dos secrets foi deixado em texto plano para facilitar a compreensão e também passado para os respectivos componentes.

O configmap foi decomposto em várias partes no diretório script para facilitar a compreensão e algumas envs foram substituidas diretamente no script para ajuda.


falta:
    verificar os deployments
    roles
    service
    serviceacccount
    ingress