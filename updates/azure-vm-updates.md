# Azure VM Updates

Generated: 2026-08-07 12:45:43 UTC

Source: Azure Resource Graph patchassessmentresources. This report is read-only: it does not install patches and does not reboot VMs.

## Summary

| Metric | Value |
| --- | ---: |
| VMs with patch assessment | 20 |
| OK | 7 |
| Updates pending | 3 |
| Reboot pending | 0 |
| Assessment warnings/errors | 10 |
| Assessment not succeeded | 1 |
| VMs with Ubuntu ESM required patches | 9 |
| Costo mensual AZ acumulado | USD 408.12 |
| Total security updates | 1194 |
| Total critical updates | 0 |
| Total pending patches listed | 1343 |

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
| devapp-greenpeace-cl-srv | Linux | assessment_warning | 245 | 0 | 61 | 189 | False | 2026-08-06T17:21:16Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| WebSrv-AppCoupon-srv | Linux | assessment_warning | 244 | 0 | 77 | 185 | False | 2026-08-07T03:46:26Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Webserver-Ar-Dev | Linux | assessment_warning | 189 | 0 | 2 | 189 | False | 2026-08-07T02:38:34Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 157 | 0 | 2 | 157 | False | 2026-08-07T10:31:58Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 144 | 0 | 0 | 144 | False | 2026-08-07T02:56:50Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 141 | 0 | 0 | 141 | False | 2026-08-07T02:59:43Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 38 | 0 | 13 | 0 | False | 2026-08-06T17:54:56Z |  |
| forms-magma-api-srv | Linux | assessment_warning | 18 | 0 | 0 | 2 | False | 2026-08-06T16:49:14Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| salvemoslosglaciares-srv | Linux | assessment_warning | 9 | 0 | 4 | 9 | False | 2026-08-07T06:20:02Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 9 | 0 | 0 | 9 | False | 2026-08-06T16:02:34Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-srv | Linux | updates_pending | 0 | 0 | 13 | 0 | False | 2026-08-06T17:18:22Z |  |
| greenpos-colombia-srv | Linux | updates_pending | 0 | 0 | 4 | 0 | False | 2026-08-07T02:31:26Z |  |
| UniFi-Controller-VM | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-08-06T05:10:43Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| ADDI-2024-srv | Windows | ok | 0 | 0 | 0 | 0 | False | 2026-08-07T02:53:24Z |  |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-06T04:03:27Z |  |
| Dominga-HDD-VM | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-07T03:51:55Z |  |
| FGARG-v2-2024 | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-06T16:25:09Z |  |
| middleware-gui-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-06T06:18:39Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-06T05:09:04Z |  |
| Monitores-Grafana-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-07T03:03:18Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
