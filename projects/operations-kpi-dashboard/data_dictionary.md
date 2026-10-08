# Data Dictionary

| Column | Type | Description |
|---|---|---|
| ticket_id | Text | Synthetic work-item identifier |
| received_at | Datetime | Time the work item entered the queue |
| due_at | Datetime | SLA due timestamp based on priority |
| completed_at | Datetime | Completion timestamp; blank for open work |
| status | Text | Completed, Open, Assigned, or Pending |
| priority | Text | Critical, High, Medium, or Low |
| team | Text | Operational team |
| analyst | Text | Synthetic assigned analyst |
| category | Text | Work category |
| channel | Text | Intake source |
| reopened_flag | Integer | 1 if the completed item was reopened |
| exception_flag | Integer | 1 if the item required an exception/escalation |

All records are synthetic and were generated for portfolio use.
