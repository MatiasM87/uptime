# Azure VM Updates

Generated: 2026-09-05 14:21:29 UTC

Source: Azure Resource Graph patchassessmentresources. This report is read-only: it does not install patches and does not reboot VMs.

## Summary

| Metric | Value |
| --- | ---: |
| VMs with patch assessment | 21 |
| OK | 2 |
| Updates pending | 7 |
| Reboot pending | 0 |
| Assessment warnings/errors | 9 |
| Assessment not succeeded | 4 |
| VMs with Ubuntu ESM required patches | 11 |
| Costo mensual AZ acumulado | USD 350.88 |
| Total security updates | 647 |
| Total critical updates | 0 |
| Total pending patches listed | 1443 |

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
| Webserver-Ar-Dev | Linux | assessment_warning | 200 | 0 | 0 | 200 | False | 2026-09-04T14:05:59Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 168 | 0 | 2 | 168 | False | 2026-09-05T10:32:04Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 152 | 0 | 0 | 152 | False | 2026-09-05T01:02:44Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 71 | 0 | 13 | 0 | False | 2026-09-04T23:01:13Z |  |
| salvemoslosglaciares-srv | Linux | assessment_warning | 15 | 0 | 5 | 9 | False | 2026-09-05T06:08:36Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 15 | 0 | 0 | 9 | False | 2026-09-04T14:55:46Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Dominga-HDD-VM | Linux | updates_pending | 9 | 0 | 0 | 0 | False | 2026-09-05T00:21:10Z |  |
| forms-magma-api-srv | Linux | assessment_warning | 8 | 0 | 0 | 2 | False | 2026-09-05T01:38:12Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-gui-srv | Linux | updates_pending | 3 | 0 | 2 | 0 | False | 2026-09-04T05:37:10Z |  |
| middleware-integracion-srv | Linux | updates_pending | 2 | 0 | 13 | 0 | False | 2026-09-05T02:45:42Z |  |
| FGARG-v2-2024 | Linux | updates_pending | 2 | 0 | 0 | 0 | False | 2026-09-05T01:51:18Z |  |
| Monitores-Grafana-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-09-04T17:39:15Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipeit-prod-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-09-03T05:02:15Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| devapp-greenpeace-cl-srv | Linux | assessment_attention | 0 | 0 | 309 | 191 | False | 2026-09-05T02:21:09Z | Ubuntu Pro/ESM likely required |
| WebSrv-AppCoupon-srv | Linux | assessment_attention | 0 | 0 | 324 | 179 | False | 2026-09-04T14:10:30Z | Ubuntu Pro/ESM likely required |
| Greenpos-Chile-srv | Linux | assessment_attention | 0 | 0 | 155 | 155 | False | 2026-09-05T01:10:50Z | Ubuntu Pro/ESM likely required |
| greenpos-colombia-srv | Linux | updates_pending | 0 | 0 | 5 | 0 | False | 2026-09-05T11:06:50Z |  |
| ADDI-2024-srv | Windows | updates_pending | 0 | 0 | 0 | 0 | False | 2026-09-05T02:51:16Z |  |
| UniFi-Controller-VM | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-09-04T03:04:58Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-09-03T03:51:53Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-09-03T05:00:34Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
