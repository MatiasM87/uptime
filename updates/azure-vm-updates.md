# Azure VM Updates

Generated: 2026-08-12 03:30:23 UTC

Source: Azure Resource Graph patchassessmentresources. This report is read-only: it does not install patches and does not reboot VMs.

## Summary

| Metric | Value |
| --- | ---: |
| VMs with patch assessment | 20 |
| OK | 8 |
| Updates pending | 2 |
| Reboot pending | 0 |
| Assessment warnings/errors | 10 |
| Assessment not succeeded | 1 |
| VMs with Ubuntu ESM required patches | 9 |
| Costo mensual AZ acumulado | USD 569.82 |
| Total security updates | 1192 |
| Total critical updates | 0 |
| Total pending patches listed | 1331 |

## Automation and backups

| Metric | Value |
| --- | ---: |
| Published runbooks | 9 |
| Runbooks whose latest job completed | 5 |
| Runbooks whose latest job failed | 2 |
| Protected VMs | 28 |
| Backups reported healthy by Azure | 28 |
| Backups outside their RPO threshold | 11 |

## VM Detail

| VM | OS | Status | Security | Critical | Other | ESM | Reboot | Last assessment | Notes |
| --- | --- | --- | ---: | ---: | ---: | ---: | --- | --- | --- |
| devapp-greenpeace-cl-srv | Linux | assessment_warning | 245 | 0 | 61 | 189 | False | 2026-08-11T17:15:17Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| WebSrv-AppCoupon-srv | Linux | assessment_warning | 244 | 0 | 77 | 185 | False | 2026-08-11T03:45:08Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Webserver-Ar-Dev | Linux | assessment_warning | 189 | 0 | 0 | 189 | False | 2026-08-11T04:08:32Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 157 | 0 | 2 | 157 | False | 2026-08-11T10:33:23Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 144 | 0 | 0 | 144 | False | 2026-08-12T03:20:19Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 141 | 0 | 0 | 141 | False | 2026-08-12T03:23:10Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 45 | 0 | 13 | 0 | False | 2026-08-11T19:48:47Z |  |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 9 | 0 | 0 | 9 | False | 2026-08-11T07:38:01Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| salvemoslosglaciares-srv | Linux | assessment_warning | 9 | 0 | 0 | 9 | False | 2026-08-11T04:04:49Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-srv | Linux | updates_pending | 7 | 0 | 13 | 0 | False | 2026-08-11T13:51:29Z |  |
| forms-magma-api-srv | Linux | assessment_warning | 2 | 0 | 0 | 2 | False | 2026-08-11T16:54:02Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| UniFi-Controller-VM | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-08-11T05:03:11Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| ADDI-2024-srv | Windows | ok | 0 | 0 | 0 | 0 | False | 2026-08-12T03:16:58Z |  |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-11T03:54:05Z |  |
| Dominga-HDD-VM | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-11T03:49:55Z |  |
| FGARG-v2-2024 | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-11T16:02:48Z |  |
| greenpos-colombia-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-11T03:57:52Z |  |
| middleware-gui-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-11T04:00:39Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-11T05:01:48Z |  |
| Monitores-Grafana-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-12T03:27:05Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
