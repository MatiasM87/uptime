# Azure VM Updates

Generated: 2026-10-05 06:23:26 UTC

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
| Costo mensual AZ acumulado | USD 343.54 |
| Total security updates | 1006 |
| Total critical updates | 0 |
| Total pending patches listed | 1085 |

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
| WebSrv-AppCoupon-srv | Linux | assessment_warning | 260 | 0 | 77 | 201 | False | 2026-10-05T05:56:46Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Webserver-Ar-Dev | Linux | assessment_warning | 205 | 0 | 0 | 205 | False | 2026-10-04T22:08:24Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 172 | 0 | 2 | 172 | False | 2026-10-04T10:32:55Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 159 | 0 | 0 | 159 | False | 2026-10-04T21:36:14Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 156 | 0 | 0 | 156 | False | 2026-10-04T10:09:15Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 31 | 0 | 16 | 0 | False | 2026-10-04T02:40:32Z |  |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 9 | 0 | 0 | 9 | False | 2026-10-04T15:00:39Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| salvemoslosglaciares-srv | Linux | assessment_warning | 9 | 0 | 0 | 9 | False | 2026-10-05T04:01:32Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| forms-magma-api-srv | Linux | assessment_warning | 2 | 0 | 0 | 2 | False | 2026-10-05T04:55:11Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Dominga-HDD-VM | Linux | updates_pending | 1 | 0 | 4 | 0 | False | 2026-10-02T04:13:12Z |  |
| Monitores-Grafana-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-10-04T18:58:26Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipeit-prod-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-10-05T05:15:00Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-srv | Linux | updates_pending | 0 | 0 | 16 | 0 | False | 2026-10-05T04:07:16Z |  |
| ADDI-2024-srv | Windows | updates_pending | 0 | 0 | 0 | 0 | False | 2026-10-05T02:52:05Z |  |
| devapp-greenpeace-cl-srv | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-10-05T04:07:49Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| UniFi-Controller-VM | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-10-03T22:01:18Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-10-05T03:51:50Z |  |
| FGARG-v2-2024 | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-10-05T04:59:11Z |  |
| greenpos-colombia-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-10-05T03:55:05Z |  |
| middleware-gui-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-10-05T03:57:16Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-10-05T05:07:51Z |  |
| netskope-publisher | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-10-05T04:04:18Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
