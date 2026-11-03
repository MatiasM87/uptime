# Azure VM Updates

Generated: 2026-11-03 18:55:00 UTC

Source: Azure Resource Graph patchassessmentresources. This report is read-only: it does not install patches and does not reboot VMs.

## Summary

| Metric | Value |
| --- | ---: |
| VMs with patch assessment | 22 |
| OK | 7 |
| Updates pending | 3 |
| Reboot pending | 0 |
| Assessment warnings/errors | 12 |
| Assessment not succeeded | 2 |
| VMs with Ubuntu ESM required patches | 10 |
| Costo mensual AZ acumulado | USD 288.63 |
| Total security updates | 1028 |
| Total critical updates | 0 |
| Total pending patches listed | 1079 |

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
| WebSrv-AppCoupon-srv | Linux | assessment_warning | 271 | 0 | 80 | 212 | False | 2026-11-03T05:40:18Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Webserver-Ar-Dev | Linux | assessment_warning | 216 | 0 | 0 | 216 | False | 2026-11-03T03:02:39Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 179 | 0 | 0 | 179 | False | 2026-11-03T10:33:10Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 168 | 0 | 0 | 168 | False | 2026-11-03T02:55:18Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 164 | 0 | 0 | 164 | False | 2026-11-03T02:56:51Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| salvemoslosglaciares-srv | Linux | assessment_warning | 9 | 0 | 1 | 9 | False | 2026-11-03T13:59:37Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 9 | 0 | 0 | 9 | False | 2026-11-03T03:05:23Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 8 | 0 | 10 | 0 | False | 2026-11-03T13:56:41Z |  |
| forms-magma-api-srv | Linux | assessment_warning | 2 | 0 | 0 | 2 | False | 2026-11-03T04:54:13Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Monitores-Grafana-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-11-03T02:58:55Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipeit-prod-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-11-03T05:00:10Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-srv | Linux | updates_pending | 0 | 0 | 10 | 0 | False | 2026-11-03T06:18:41Z |  |
| greenpos-colombia-srv | Linux | updates_pending | 0 | 0 | 1 | 0 | False | 2026-11-03T13:02:40Z |  |
| devapp-greenpeace-cl-srv | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-11-03T02:16:43Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| UniFi-Controller-VM | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-11-03T03:00:39Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| ADDI-2024-srv | Windows | ok | 0 | 0 | 0 | 0 | False | 2026-11-03T02:53:36Z |  |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-11-02T03:51:49Z |  |
| Dominga-HDD-VM | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-11-03T05:43:27Z |  |
| FGARG-v2-2024 | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-11-03T04:56:29Z |  |
| middleware-gui-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-11-02T03:56:09Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-11-03T04:58:41Z |  |
| netskope-publisher | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-11-02T04:00:23Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
