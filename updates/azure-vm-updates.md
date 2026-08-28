# Azure VM Updates

Generated: 2026-08-28 21:39:05 UTC

Source: Azure Resource Graph patchassessmentresources. This report is read-only: it does not install patches and does not reboot VMs.

## Summary

| Metric | Value |
| --- | ---: |
| VMs with patch assessment | 21 |
| OK | 3 |
| Updates pending | 6 |
| Reboot pending | 0 |
| Assessment warnings/errors | 10 |
| Assessment not succeeded | 2 |
| VMs with Ubuntu ESM required patches | 11 |
| Costo mensual AZ acumulado | USD 1,312.09 |
| Total security updates | 1007 |
| Total critical updates | 0 |
| Total pending patches listed | 1372 |

## Automation and backups

| Metric | Value |
| --- | ---: |
| Published runbooks | 9 |
| Runbooks whose latest job completed | 5 |
| Runbooks whose latest job failed | 3 |
| Protected VMs | 29 |
| Backups reported healthy by Azure | 29 |
| Backups outside their RPO threshold | 11 |

## VM Detail

| VM | OS | Status | Security | Critical | Other | ESM | Reboot | Last assessment | Notes |
| --- | --- | --- | ---: | ---: | ---: | ---: | --- | --- | --- |
| devapp-greenpeace-cl-srv | Linux | assessment_warning | 250 | 0 | 61 | 194 | False | 2026-08-28T03:41:27Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Webserver-Ar-Dev | Linux | assessment_warning | 194 | 0 | 0 | 194 | False | 2026-08-28T15:05:52Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 162 | 0 | 2 | 162 | False | 2026-08-28T10:32:18Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 149 | 0 | 0 | 149 | False | 2026-08-28T14:02:15Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 146 | 0 | 0 | 146 | False | 2026-08-28T02:58:44Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 36 | 0 | 6 | 0 | False | 2026-08-28T02:45:53Z |  |
| middleware-integracion-srv | Linux | updates_pending | 18 | 0 | 6 | 0 | False | 2026-08-28T00:42:29Z |  |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 14 | 0 | 0 | 9 | False | 2026-08-28T14:20:45Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| salvemoslosglaciares-srv | Linux | assessment_warning | 14 | 0 | 0 | 9 | False | 2026-08-28T02:01:39Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| forms-magma-api-srv | Linux | assessment_warning | 7 | 0 | 0 | 2 | False | 2026-08-28T03:54:18Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Dominga-HDD-VM | Linux | updates_pending | 5 | 0 | 0 | 0 | False | 2026-08-28T05:40:15Z |  |
| FGARG-v2-2024 | Linux | updates_pending | 5 | 0 | 0 | 0 | False | 2026-08-28T03:12:16Z |  |
| greenpos-colombia-srv | Linux | updates_pending | 5 | 0 | 0 | 0 | False | 2026-08-28T01:59:30Z |  |
| Monitores-Grafana-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-08-28T03:02:54Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipeit-prod-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-08-27T05:01:52Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| WebSrv-AppCoupon-srv | Linux | assessment_attention | 0 | 0 | 318 | 173 | False | 2026-08-28T14:13:25Z | Ubuntu Pro/ESM likely required |
| ADDI-2024-srv | Windows | updates_pending | 0 | 0 | 0 | 0 | False | 2026-08-28T14:51:24Z |  |
| UniFi-Controller-VM | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-08-28T21:35:42Z |  |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-27T03:51:43Z |  |
| middleware-gui-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-27T03:57:04Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-27T05:00:19Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
