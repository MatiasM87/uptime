# Azure VM Updates

Generated: 2026-11-20 19:29:32 UTC

Source: Azure Resource Graph patchassessmentresources. This report is read-only: it does not install patches and does not reboot VMs.

## Summary

| Metric | Value |
| --- | ---: |
| VMs with patch assessment | 22 |
| OK | 6 |
| Updates pending | 4 |
| Reboot pending | 0 |
| Assessment warnings/errors | 12 |
| Assessment not succeeded | 2 |
| VMs with Ubuntu ESM required patches | 10 |
| Costo mensual AZ acumulado | USD 1,152.84 |
| Total security updates | 1086 |
| Total critical updates | 0 |
| Total pending patches listed | 1113 |

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
| WebSrv-AppCoupon-srv | Linux | assessment_warning | 278 | 0 | 83 | 219 | False | 2026-11-19T17:05:15Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Webserver-Ar-Dev | Linux | assessment_warning | 223 | 0 | 0 | 223 | False | 2026-11-20T03:02:43Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 184 | 0 | 3 | 184 | False | 2026-11-20T10:33:08Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 174 | 0 | 0 | 174 | False | 2026-11-20T02:55:10Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 170 | 0 | 0 | 170 | False | 2026-11-20T02:56:36Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| salvemoslosglaciares-srv | Linux | assessment_warning | 14 | 0 | 1 | 10 | False | 2026-11-20T09:01:58Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Dominga-HDD-VM | Linux | updates_pending | 13 | 0 | 0 | 0 | False | 2026-11-20T09:45:18Z |  |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 10 | 0 | 0 | 10 | False | 2026-11-20T03:09:06Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-gui-srv | Linux | updates_pending | 9 | 0 | 0 | 0 | False | 2026-11-19T09:02:32Z |  |
| forms-magma-api-srv | Linux | assessment_warning | 6 | 0 | 0 | 2 | False | 2026-11-20T07:01:40Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARG-v2-2024 | Linux | updates_pending | 3 | 0 | 0 | 0 | False | 2026-11-20T07:10:33Z |  |
| Monitores-Grafana-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-11-20T02:59:09Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipeit-prod-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-11-19T05:00:09Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| greenpos-colombia-srv | Linux | updates_pending | 0 | 0 | 1 | 0 | False | 2026-11-20T13:02:34Z |  |
| devapp-greenpeace-cl-srv | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-11-20T02:16:43Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| UniFi-Controller-VM | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-11-20T03:00:55Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| ADDI-2024-srv | Windows | ok | 0 | 0 | 0 | 0 | False | 2026-11-20T02:53:27Z |  |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-11-19T03:51:35Z |  |
| middleware-integracion-prod-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-11-20T06:13:28Z |  |
| middleware-integracion-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-11-20T06:19:53Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-11-19T04:58:28Z |  |
| netskope-publisher | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-11-19T04:00:19Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
