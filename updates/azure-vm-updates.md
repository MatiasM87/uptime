# Azure VM Updates

Generated: 2026-08-30 15:49:43 UTC

Source: Azure Resource Graph patchassessmentresources. This report is read-only: it does not install patches and does not reboot VMs.

## Summary

| Metric | Value |
| --- | ---: |
| VMs with patch assessment | 21 |
| OK | 3 |
| Updates pending | 6 |
| Reboot pending | 0 |
| Assessment warnings/errors | 11 |
| Assessment not succeeded | 2 |
| VMs with Ubuntu ESM required patches | 11 |
| Costo mensual AZ acumulado | USD 1,462.07 |
| Total security updates | 984 |
| Total critical updates | 0 |
| Total pending patches listed | 1353 |

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
| devapp-greenpeace-cl-srv | Linux | assessment_warning | 250 | 0 | 61 | 194 | False | 2026-08-30T11:41:16Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Webserver-Ar-Dev | Linux | assessment_warning | 194 | 0 | 0 | 194 | False | 2026-08-30T00:05:53Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 162 | 0 | 2 | 162 | False | 2026-08-30T10:32:53Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 149 | 0 | 0 | 149 | False | 2026-08-30T10:31:54Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 146 | 0 | 0 | 146 | False | 2026-08-29T12:04:02Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 36 | 0 | 7 | 0 | False | 2026-08-30T10:06:38Z |  |
| salvemoslosglaciares-srv | Linux | assessment_warning | 14 | 0 | 1 | 9 | False | 2026-08-29T18:07:48Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 14 | 0 | 0 | 9 | False | 2026-08-30T00:58:33Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| forms-magma-api-srv | Linux | assessment_warning | 7 | 0 | 0 | 2 | False | 2026-08-30T12:38:17Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Dominga-HDD-VM | Linux | updates_pending | 5 | 0 | 0 | 0 | False | 2026-08-30T06:40:23Z |  |
| middleware-gui-srv | Linux | updates_pending | 5 | 0 | 0 | 0 | False | 2026-08-29T05:07:10Z |  |
| Monitores-Grafana-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-08-30T03:39:14Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipeit-prod-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-08-27T05:01:52Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| WebSrv-AppCoupon-srv | Linux | assessment_attention | 0 | 0 | 318 | 173 | False | 2026-08-29T23:20:45Z | Ubuntu Pro/ESM likely required |
| middleware-integracion-srv | Linux | updates_pending | 0 | 0 | 7 | 0 | False | 2026-08-30T03:10:27Z |  |
| ADDI-2024-srv | Windows | updates_pending | 0 | 0 | 0 | 0 | False | 2026-08-30T02:51:26Z |  |
| greenpos-colombia-srv | Linux | updates_pending | 0 | 0 | 1 | 0 | False | 2026-08-29T22:07:48Z |  |
| UniFi-Controller-VM | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-08-28T21:38:11Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-27T03:51:43Z |  |
| FGARG-v2-2024 | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-30T12:55:10Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-27T05:00:19Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
