# Suggested Power BI Measures

```DAX
Received =
COUNTROWS('Operational Tickets')

Completed =
CALCULATE(
    COUNTROWS('Operational Tickets'),
    'Operational Tickets'[status] = "Completed"
)

Open Backlog =
CALCULATE(
    COUNTROWS('Operational Tickets'),
    'Operational Tickets'[status] <> "Completed"
)

On Time Completed =
CALCULATE(
    COUNTROWS('Operational Tickets'),
    'Operational Tickets'[status] = "Completed",
    'Operational Tickets'[completed_at] <= 'Operational Tickets'[due_at]
)

On Time % =
DIVIDE([On Time Completed], [Completed], 0)

Reopened =
CALCULATE(
    COUNTROWS('Operational Tickets'),
    'Operational Tickets'[reopened_flag] = 1
)

Reopen Rate =
DIVIDE([Reopened], [Completed], 0)

Exceptions =
CALCULATE(
    COUNTROWS('Operational Tickets'),
    'Operational Tickets'[exception_flag] = 1
)

Exception Rate =
DIVIDE([Exceptions], [Received], 0)

Average Closure Hours =
AVERAGEX(
    FILTER(
        'Operational Tickets',
        'Operational Tickets'[status] = "Completed"
    ),
    DATEDIFF(
        'Operational Tickets'[received_at],
        'Operational Tickets'[completed_at],
        HOUR
    )
)
```
