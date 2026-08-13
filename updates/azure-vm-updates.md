# Azure VM Updates

Generated: 2026-08-13 12:54:27 UTC

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
| Costo mensual AZ acumulado | USD 762.63 |
| Total security updates | 1185 |
| Total critical updates | 0 |
| Total pending patches listed | 1324 |

## Automation and backups

| Metric | Value |
| --- | ---: |
| Published runbooks | 9 |
| Runbooks whose latest job completed | 5 |
| Runbooks whose latest job failed | 3 |
| Protected VMs | 28 |
| Backups reported healthy by Azure | 28 |
| Backups outside their RPO threshold | 11 |

## VM Detail

| VM | OS | Status | Security | Critical | Other | ESM | Reboot | Last assessment | Notes |
| --- | --- | --- | ---: | ---: | ---: | ---: | --- | --- | --- |
| devapp-greenpeace-cl-srv | Linux | assessment_warning | 245 | 0 | 61 | 189 | False | 2026-08-13T05:39:06Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| WebSrv-AppCoupon-srv | Linux | assessment_warning | 244 | 0 | 77 | 185 | False | 2026-08-13T03:48:36Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Webserver-Ar-Dev | Linux | assessment_warning | 189 | 0 | 0 | 189 | False | 2026-08-13T04:06:43Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 157 | 0 | 2 | 157 | False | 2026-08-12T10:32:18Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 144 | 0 | 0 | 144 | False | 2026-08-13T03:00:38Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 141 | 0 | 0 | 141 | False | 2026-08-13T03:03:39Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 45 | 0 | 13 | 0 | False | 2026-08-12T17:58:12Z |  |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 9 | 0 | 0 | 9 | False | 2026-08-13T04:10:51Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| salvemoslosglaciares-srv | Linux | assessment_warning | 9 | 0 | 0 | 9 | False | 2026-08-13T04:03:04Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| forms-magma-api-srv | Linux | assessment_warning | 2 | 0 | 0 | 2 | False | 2026-08-13T04:55:31Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-srv | Linux | updates_pending | 0 | 0 | 13 | 0 | False | 2026-08-13T05:03:57Z |  |
| UniFi-Controller-VM | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-08-13T05:02:40Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| ADDI-2024-srv | Windows | ok | 0 | 0 | 0 | 0 | False | 2026-08-13T02:57:18Z |  |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-13T03:53:42Z |  |
| Dominga-HDD-VM | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-13T03:53:56Z |  |
| FGARG-v2-2024 | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-13T04:58:51Z |  |
| greenpos-colombia-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-13T03:57:14Z |  |
| middleware-gui-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-13T03:58:59Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-13T05:01:25Z |  |
| Monitores-Grafana-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-13T03:07:25Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
