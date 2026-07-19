# Azure VM Updates

Generated: 2026-07-19 16:43:55 UTC

Source: Azure Resource Graph patchassessmentresources. This report is read-only: it does not install patches and does not reboot VMs.

## Summary

| Metric | Value |
| --- | ---: |
| VMs with patch assessment | 21 |
| OK | 5 |
| Updates pending | 6 |
| Reboot pending | 0 |
| Assessment warnings/errors | 9 |
| Assessment not succeeded | 1 |
| VMs with Ubuntu ESM required patches | 10 |
| Costo mensual AZ acumulado | USD 1,095.41 |
| Total security updates | 918 |
| Total critical updates | 0 |
| Total pending patches listed | 1310 |

## VM Detail

| VM | OS | Status | Security | Critical | Other | ESM | Reboot | Last assessment | Notes |
| --- | --- | --- | ---: | ---: | ---: | ---: | --- | --- | --- |
| devapp-greenpeace-cl-srv | Linux | assessment_warning | 242 | 0 | 59 | 186 | False | 2026-07-19T00:46:16Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Webserver-Ar-Dev | Linux | assessment_warning | 186 | 0 | 0 | 186 | False | 2026-07-18T22:07:18Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 154 | 0 | 0 | 154 | False | 2026-07-19T10:32:00Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 141 | 0 | 0 | 141 | False | 2026-07-18T23:31:30Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 138 | 0 | 0 | 138 | False | 2026-07-19T10:13:53Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 12 | 0 | 6 | 0 | False | 2026-07-19T07:14:30Z |  |
| salvemoslosglaciares-srv | Linux | assessment_warning | 12 | 0 | 6 | 9 | False | 2026-07-19T09:14:12Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 12 | 0 | 3 | 9 | False | 2026-07-19T02:08:25Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-gui-srv | Linux | updates_pending | 6 | 0 | 2 | 0 | False | 2026-07-19T05:08:08Z |  |
| middleware-integracion-srv | Linux | updates_pending | 5 | 0 | 6 | 0 | False | 2026-07-19T04:10:13Z |  |
| forms-magma-api-srv | Linux | assessment_warning | 5 | 0 | 3 | 2 | False | 2026-07-19T06:09:58Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARG-v2-2024 | Linux | updates_pending | 3 | 0 | 2 | 0 | False | 2026-07-19T03:10:01Z |  |
| openvpn-gpandino | Linux | assessment_warning | 2 | 0 | 0 | 2 | False | 2026-07-14T18:00:20Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| WebSrv-AppCoupon-srv | Linux | assessment_attention | 0 | 0 | 308 | 174 | False | 2026-07-19T00:25:19Z | Ubuntu Pro/ESM likely required |
| greenpos-colombia-srv | Linux | updates_pending | 0 | 0 | 5 | 0 | False | 2026-07-19T09:13:26Z |  |
| ADDI-2024-srv | Windows | updates_pending | 0 | 0 | 0 | 0 | False | 2026-07-19T02:51:29Z |  |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-16T03:53:48Z |  |
| Dominga-HDD-VM | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-19T11:53:41Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-16T05:01:50Z |  |
| Monitores-Grafana-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-19T05:09:34Z |  |
| UniFi-Controller-VM | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-16T05:04:40Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
