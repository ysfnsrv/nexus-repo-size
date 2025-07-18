# nexus-repo-size
Bash script to calculate Nexus Repository sizes by reading .properties files from blob storage, without relying on Nexus API or Groovy.

# Nexus Blobstore Repository Size Analyzer

This Bash script analyzes Nexus Repository Manager's blob storage directly by reading `.properties` metadata files. It calculates the total size used by each repository bucket (`@Bucket.repo-name`) based on the `size=` fields.

✅ Works even when:
- Nexus UI/API doesn't show per-repository size
- Groovy scripts are disabled in newer Nexus versions

## 🔍 What It Does

- Scans all `.properties` files under the blob storage (e.g. `/var/nexus/blobs/default/content`)
- Extracts `@Bucket.repo-name` and corresponding `size=...` fields
- Aggregates total size **in bytes** per repository
- Outputs a clean, tabular summary of repository sizes


## 🛠️ Requirements

- Bash
- `grep`, `cut`, `bc` (standard Unix tools)
- (Optional) `curl` and `jq` — if using Nexus REST API to list repositories

   `apt install curl jq -y`

## 🔐 Security Tip: Store Credentials in Vault

For secure environments, **avoid hardcoding your Nexus credentials** in the script.

Instead, fetch them at runtime using a secrets manager like [HashiCorp Vault](https://www.vaultproject.io/):

```bash
USER=$(vault kv get -field=username secret/nexus)
PASS=$(vault kv get -field=password secret/nexus)
```

## 📦 Sample Output

Собираем список репозиториев с Nexus API...
Поиск всех .properties файлов...
Обработка файлов...

```
📦 Размеры репозиториев (в байтах):
Repository                                    Bytes
---------                                    ------
elastic-proxy                              49101741
qa-test                                  7848270237
DockerHub-proxy                          1893982703
automation-test                              255004
redhat-proxy                              317125782
argocd-public-repo                          9041680
k8s-proxy                                   3397879
maven-central                             636036371
nuget.org-proxy                                7546
my-app                                 824274444183
gradle-raw                                608709246
maven-releases                            584001341
```
