/*
	Created By:       Saritha Kommineni
	Date created:     03-Oct-2011
	Purpose:          Insert records to table [tescosubscription].[PackageMaster]
	Usage:            Data used for Delivery Saver scheduler
	

	--Modifications History--
	Changed On  Changed By        Defect            Description
*/ 

SET NOCOUNT ON

DECLARE @inserted INT, @exists INT

SELECT @inserted = 0, @exists = 0

CREATE TABLE #InsertData
(
              [PackageID] SMALLINT NOT NULL,
              [PackageName] VARCHAR(100) NOT NULL,
              [PackageDescription] [varchar](250) NULL, 
              [UTCCreatedDateTime] DATETIME NOT NULL CONSTRAINT [DF_PackageMaster_UTCCreatedDateTime]  DEFAULT (getutcdate()),
	          [UTCUpdatedDateTime] DATETIME NOT NULL CONSTRAINT [DF_PackageMaster_UTCUpdatedDateTime]  DEFAULT (getutcdate()),
		 CONSTRAINT [PK_PackageMaster] PRIMARY KEY CLUSTERED 
              (
			  [PackageID] DESC
		 )WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
		 ) ON [PRIMARY]

INSERT INTO #INSERTDATA(
	[PackageID],
	[PackageName],
    [PackageDescription])

SELECT 1,'TescoSubscriptionRecurringPayment','Renews customer subscriptions'
UNION
SELECT 2,'TescoSubscriptionNotification','Sends reminder emails'

UPDATE DestTable
	SET DestTable.[PackageName]=ToInsert.[PackageName],
		DestTable.UTCUpdatedDateTime=ToInsert.[UTCCreatedDateTime]
FROM #INSERTDATA ToInsert
JOIN [tescosubscription].[PackageMaster] DestTable
ON  ToInsert.PackageID = DestTable.PackageID
WHERE DestTable.[PackageName]<>ToInsert.[PackageName]

SELECT @Exists=@@rowcount

INSERT INTO [tescosubscription].[PackageMaster](
	[PackageID],
	[PackageName],
    [PackageDescription],
	UTCCreatedDateTime,
	UTCUpdatedDateTime)
SELECT 
	ToInsert.PackageID,
	ToInsert.PackageName,
ToInsert.PackageDescription,
	ToInsert.UTCCreatedDateTime,
	ToInsert.UTCUpdatedDateTime
FROM #INSERTDATA ToInsert
LEFT JOIN [tescosubscription].[PackageMaster] DestTable
ON  ToInsert.Packageid = DestTable.Packageid
WHERE DestTable.Packageid Is Null

SET @inserted = @@ROWCOUNT

PRINT 'UPDATED - ' + CONVERT(varchar(10), @exists) + ' record(s) updated in [tescosubscription].[PackageMaster].'
PRINT 'INSERTED - ' + CONVERT(varchar(10), @inserted) + ' record(s) into [tescosubscription].[PackageMaster].'

DROP TABLE #INSERTDATA

GO
