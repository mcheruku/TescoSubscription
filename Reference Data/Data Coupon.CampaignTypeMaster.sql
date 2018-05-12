USE [TescoSubscription]
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE MASTER DATA  
** NAME           : TABLE [Coupon].[CampaignTypeMaster]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** Description    : THIS SCRIPT WILL INSERT MASTER DATA IN [Coupon].[CampaignTypeMaster]
** DATE WRITTEN   : 06/03/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): NONE
*******************************************************************************************  
*******************************************************************************************/
SET NOCOUNT ON

DECLARE @inserted INT, @exists INT

SELECT @inserted = 0, @exists = 0

CREATE TABLE #InsertData(
		[CampaignTypeID] [INT] NOT NULL,
		[CampaignTypeName] [NVARCHAR](50) NOT NULL,
		[Description] [NVARCHAR](200) NULL,
		[IsActive] [BIT] NOT NULL,
		[UTCCreatedDateTime] [SMALLDATETIME] NOT NULL,
		[UTCUpdatedDateTime] [SMALLDATETIME] NOT NULL,
	 CONSTRAINT [PK_TEMPCampaignTypeMaster] PRIMARY KEY CLUSTERED 
	(
		[CampaignTypeID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE #InsertData ADD  CONSTRAINT [DF_TEMPINSERTDATA_IsActive]  DEFAULT ((0)) FOR [IsActive]

	ALTER TABLE #InsertData ADD  CONSTRAINT [DF_TEMPINSERTDATA_UTCCREATEDEDATETIME]  DEFAULT (GETUTCDATE()) FOR [UTCCreatedDateTime]

	ALTER TABLE #InsertData ADD  CONSTRAINT [DF_TEMPINSERTDATA_UTCUpdatedDateTime]  DEFAULT (GETUTCDATE()) FOR [UTCUpdatedDateTime]

INSERT INTO #INSERTDATA(
		[CampaignTypeID],
		[CampaignTypeName],
		[Description],
		[IsActive]
		)
SELECT 1,'Unlinked Coupon','Description for unlinked Coupon',1
UNION ALL
SELECT 2,'Unique Coupon','Description for unique Coupon',1
UNION ALL
SELECT 3,'Customer Linked Coupon','Description for customer linked Coupon',1

SELECT @exists = COUNT(1) 
FROM #INSERTDATA ToInsert
JOIN [Coupon].[CampaignTypeMaster] DestTable
ON  ToInsert.[CampaignTypeID] = DestTable.[CampaignTypeID]

INSERT INTO [Coupon].[CampaignTypeMaster](
	[CampaignTypeName],
	[Description],
	[IsActive])
SELECT 
	ToInsert.[CampaignTypeName],
	ToInsert.[Description],
	ToInsert.[IsActive]
FROM #INSERTDATA ToInsert
LEFT JOIN [Coupon].[CampaignTypeMaster] DestTable
ON  ToInsert.[CampaignTypeID] = DestTable.[CampaignTypeID]
WHERE DestTable.[CampaignTypeID] Is Null

SET @inserted = @@ROWCOUNT

PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' record(s) already existed in [Coupon].[CampaignTypeMaster].'
PRINT 'INSERTED - ' + CONVERT(varchar(10), @inserted) + ' record(s) into [Coupon].[CampaignTypeMaster].'

DROP TABLE #INSERTDATA

GO