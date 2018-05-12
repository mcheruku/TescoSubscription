/*
	Created By:       Rajendra Singh
	Date created:     27-Jul-2011
	Purpose:          Insert records to table [tescosubscription].[StatusMaster]
	Usage:            Data used for subscriptions 
	Data Type:        Hybrid - Updated via DB script or application


	--Modifications History--
	Changed On	    Changed By        Defect            Description
	24-Aug-2011 	Saritha K						Added new status 11,12
	16-Jan-2013     Robin                           Added 2 new Status 16,17
	07-Mar-2013     Robin                           Aded and updated new status 17,18,19
*/ 

SET NOCOUNT ON

DECLARE @inserted INT, @exists INT

SELECT @inserted = 0, @exists = 0

CREATE TABLE #InsertData(
	[StatusId] [tinyint] NOT NULL,
	[StatusCode] [tinyint] NOT NULL,
	[StatusName] [varchar](20) NOT NULL,
	[StatusType] [varchar](50) NOT NULL,
	[UTCCreatedDateTime] [datetime] NOT NULL , 
	[UTCUpdatedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_StatusMaster] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE #InsertData ADD  CONSTRAINT [DF_StatusMaster_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]
ALTER TABLE #InsertData ADD  CONSTRAINT [DF_StatusMaster_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

INSERT INTO #INSERTDATA(
	StatusId,
	StatusCode,
	StatusName,
	StatusType)
SELECT 1,0,'Success','Payment'
UNION ALL
SELECT 2,1,'Card Failure','Payment'
UNION ALL
SELECT 3,2,'System Failure','Payment'
UNION ALL
SELECT 4,3,'none','Payment'
UNION ALL
SELECT 5,0,'In Progress','CustomerSubsProcessing'
UNION ALL
SELECT 6,1,'Success','CustomerSubsProcessing'
UNION ALL
SELECT 7,0,'Suspended','CustomerSubs'
UNION ALL
SELECT 8,1,'Active','CustomerSubs'
UNION ALL
SELECT 9,2,'Cancelled','CustomerSubs'
UNION ALL
SELECT 10,3,'Stopped','CustomerSubs'
UNION ALL
SELECT 11,4,'Pending Stop','CustomerSubs'
UNION ALL
SELECT 12,0,'In progress','SSISPackage'
UNION ALL
SELECT 13,1,'Success','SSISPackage'
UNION ALL
SELECT 14,2,'Failure','SSISPackage'
UNION ALL
SELECT 15,5,'Order Initiated','CustomerSubs'
UNION ALL
SELECT 16,6,'Switched','CustomerSubs'
UNION ALL
SELECT 17,7,'Switch Initiated','CustomerSubsSwitch'
UNION ALL
SELECT 18,8,'Switch Cancelled','CustomerSubsSwitch'
UNION ALL
SELECT 19,9,'Switch Sucess','CustomerSubsSwitch'

SELECT @exists = COUNT(1) 
FROM #INSERTDATA ToInsert
JOIN [tescosubscription].[StatusMaster] DestTable
ON  ToInsert.StatusId = DestTable.StatusId

INSERT INTO [tescosubscription].[StatusMaster](
	StatusId,
	StatusCode,
	StatusName,
	StatusType,
	UTCCreatedDateTime,
	UTCUpdatedDateTime)
SELECT 
	ToInsert.StatusId,
	ToInsert.StatusCode,
	ToInsert.StatusName,
	ToInsert.StatusType,
	ToInsert.UTCCreatedDateTime,
	ToInsert.UTCUpdatedDateTime
FROM #INSERTDATA ToInsert
LEFT JOIN [tescosubscription].[StatusMaster] DestTable
ON  ToInsert.StatusId = DestTable.StatusId
WHERE DestTable.StatusId Is Null

SET @inserted = @@ROWCOUNT

PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' record(s) already existed in [tescosubscription].[StatusMaster].'
PRINT 'INSERTED - ' + CONVERT(varchar(10), @inserted) + ' record(s) into [tescosubscription].[StatusMaster].'

DROP TABLE #INSERTDATA

GO
