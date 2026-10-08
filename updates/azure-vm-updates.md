# Azure VM Updates

Generated: 2026-10-08 06:44:53 UTC

Source: Azure Resource Graph patchassessmentresources. This report is read-only: it does not install patches and does not reboot VMs.

## Summary

| Metric | Value |
| --- | ---: |
| VMs with patch assessment | 22 |
| OK | 7 |
| Updates pending | 2 |
| Reboot pending | 0 |
| Assessment warnings/errors | 13 |
| Assessment not succeeded | 3 |
| VMs with Ubuntu ESM required patches | 10 |
| Costo mensual AZ acumulado | USD 475.89 |
| Total security updates | 1024 |
| Total critical updates | 0 |
| Total pending patches listed | 1083 |

## Automation and backups

| Metric | Value |
| --- | ---: |
| Published runbooks | 9 |
| Runbooks whose latest job completed | 5 |
| Runbooks whose latest job failed | 2 |
| Protected VMs | 29 |
| Backups reported healthy by Azure | 29 |
| Backups outside their RPO threshold | 11 |

## VM Detail

| VM | OS | Status | Security | Critical | Other | ESM | Reboot | Last assessment | Notes |
| --- | --- | --- | ---: | ---: | ---: | ---: | --- | --- | --- |
| WebSrv-AppCoupon-srv | Linux | assessment_warning | 263 | 0 | 77 | 204 | False | 2026-10-08T05:47:22Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Webserver-Ar-Dev | Linux | assessment_warning | 208 | 0 | 0 | 208 | False | 2026-10-08T03:09:27Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 175 | 0 | 2 | 175 | False | 2026-10-07T10:31:51Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 162 | 0 | 0 | 162 | False | 2026-10-08T02:56:15Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 159 | 0 | 0 | 159 | False | 2026-10-08T02:59:41Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 35 | 0 | 11 | 0 | False | 2026-10-07T08:11:11Z |  |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 9 | 0 | 0 | 9 | False | 2026-10-08T03:14:17Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| salvemoslosglaciares-srv | Linux | assessment_warning | 9 | 0 | 0 | 9 | False | 2026-10-08T04:04:23Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| forms-magma-api-srv | Linux | assessment_warning | 2 | 0 | 0 | 2 | False | 2026-10-08T04:56:05Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Monitores-Grafana-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-10-08T03:04:08Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipeit-prod-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-10-08T05:04:20Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-srv | Linux | updates_pending | 0 | 0 | 9 | 0 | False | 2026-10-07T06:11:08Z |  |
| devapp-greenpeace-cl-srv | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-10-08T04:10:33Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Dominga-HDD-VM | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-10-08T05:46:42Z | Provisioning of VM extension LinuxPatchExtension has timed out. Extension provisioning has taken too long to complete. The extension did ... |
| UniFi-Controller-VM | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-10-08T03:05:53Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| ADDI-2024-srv | Windows | ok | 0 | 0 | 0 | 0 | False | 2026-10-08T02:52:59Z |  |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-10-08T03:51:59Z |  |
| FGARG-v2-2024 | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-10-08T04:59:55Z |  |
| greenpos-colombia-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-10-08T03:55:48Z |  |
| middleware-gui-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-10-08T03:58:39Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-10-08T05:02:16Z |  |
| netskope-publisher | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-10-08T04:07:06Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
