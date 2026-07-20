# Azure VM Updates

Generated: 2026-07-20 04:29:10 UTC

Source: Azure Resource Graph patchassessmentresources. This report is read-only: it does not install patches and does not reboot VMs.

## Summary

| Metric | Value |
| --- | ---: |
| VMs with patch assessment | 21 |
| OK | 7 |
| Updates pending | 4 |
| Reboot pending | 0 |
| Assessment warnings/errors | 9 |
| Assessment not succeeded | 1 |
| VMs with Ubuntu ESM required patches | 10 |
| Costo mensual AZ acumulado | USD 1,107.80 |
| Total security updates | 906 |
| Total critical updates | 0 |
| Total pending patches listed | 1282 |

## VM Detail

| VM | OS | Status | Security | Critical | Other | ESM | Reboot | Last assessment | Notes |
| --- | --- | --- | ---: | ---: | ---: | ---: | --- | --- | --- |
| devapp-greenpeace-cl-srv | Linux | assessment_warning | 242 | 0 | 59 | 186 | False | 2026-07-19T00:46:16Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Webserver-Ar-Dev | Linux | assessment_warning | 186 | 0 | 0 | 186 | False | 2026-07-20T04:15:26Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 154 | 0 | 0 | 154 | False | 2026-07-19T10:32:00Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 141 | 0 | 0 | 141 | False | 2026-07-19T21:44:15Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 138 | 0 | 0 | 138 | False | 2026-07-19T10:13:53Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 12 | 0 | 6 | 0 | False | 2026-07-19T07:14:30Z |  |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 9 | 0 | 0 | 9 | False | 2026-07-20T04:19:47Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| salvemoslosglaciares-srv | Linux | assessment_warning | 9 | 0 | 0 | 9 | False | 2026-07-20T04:11:56Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-srv | Linux | updates_pending | 5 | 0 | 6 | 0 | False | 2026-07-20T02:21:36Z |  |
| forms-magma-api-srv | Linux | assessment_warning | 5 | 0 | 3 | 2 | False | 2026-07-19T17:10:33Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARG-v2-2024 | Linux | updates_pending | 3 | 0 | 2 | 0 | False | 2026-07-19T03:10:01Z |  |
| openvpn-gpandino | Linux | assessment_warning | 2 | 0 | 0 | 2 | False | 2026-07-14T18:00:20Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| WebSrv-AppCoupon-srv | Linux | assessment_attention | 0 | 0 | 308 | 174 | False | 2026-07-19T11:27:44Z | Ubuntu Pro/ESM likely required |
| ADDI-2024-srv | Windows | updates_pending | 0 | 0 | 0 | 0 | False | 2026-07-19T14:51:19Z |  |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-20T04:01:28Z |  |
| Dominga-HDD-VM | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-20T01:45:05Z |  |
| greenpos-colombia-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-20T04:05:17Z |  |
| middleware-gui-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-20T04:07:37Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-16T05:01:50Z |  |
| Monitores-Grafana-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-19T16:09:55Z |  |
| UniFi-Controller-VM | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-16T05:04:40Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
