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

## 📦 Sample Output

