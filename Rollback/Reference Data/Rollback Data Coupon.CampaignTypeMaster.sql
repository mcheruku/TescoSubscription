USE TescoSubscription
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : ROLLBACK SCRIPT  
** NAME           : Rollback Master data from [Coupon].[CampaignTypeMaster]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL ROLLBACK master data from [Coupon].[CampaignTypeMaster]
** DATE WRITTEN   : 06/05/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): NONE
*******************************************************************************************  
********************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
SET NOCOUNT ON

DECLARE @deleted INT, @notExists INT

SELECT @deleted = 0, @notExists = 0

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

	ALTER TABLE #InsertData ADD  CONSTRAINT [DF_TempInsertData_IsActive]  DEFAULT ((0)) FOR [IsActive]

	ALTER TABLE #InsertData ADD  CONSTRAINT [DF_TempInsertData_UTCCreatedDateTime]  DEFAULT (GETUTCDATE()) FOR [UTCCreatedDateTime]

	ALTER TABLE #InsertData ADD  CONSTRAINT [DF_TempInsertData_UTCUpdatedDateTime]  DEFAULT (GETUTCDATE()) FOR [UTCUpdatedDateTime]

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

SELECT @notExists = COUNT(1) 
FROM #INSERTDATA ToInsert
JOIN [Coupon].[CampaignTypeMaster] DestTable
ON  ToInsert.[CampaignTypeID] = DestTable.[CampaignTypeID]
WHERE DestTable.[CampaignTypeID] Is Null

DELETE [Coupon].[CampaignTypeMaster] 
FROM #INSERTDATA ToInsert
JOIN [Coupon].[CampaignTypeMaster] DestTable
ON  ToInsert.[CampaignTypeID] = DestTable.[CampaignTypeID]

SET @deleted  = @@ROWCOUNT

PRINT 'NOT EXISTS - ' + CONVERT(varchar(10), @notExists) + ' record(s) already existed in [Coupon].[CampaignTypeMaster].'
PRINT 'DELETED - ' + CONVERT(varchar(10), @deleted) + ' record(s) from [Coupon].[CampaignTypeMaster].'

DROP TABLE #INSERTDATA

GO