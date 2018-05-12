USE [TescoSubscription]
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE TABLE  
** NAME           : TABLE [Coupon].[Campaign]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE TABLE [Coupon].[Campaign]
** DATE WRITTEN   : 06/03/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): NONE
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[Campaign]',N'U') IS NULL
	BEGIN

	CREATE TABLE [Coupon].[Campaign](
		[CampaignID] [BIGINT] IDENTITY(1,1) NOT NULL,
		[CampaignCode] [NVARCHAR](25) NOT NULL,
		[DescriptionShort] [NVARCHAR](200) NULL,
		[DescriptionLong] [NVARCHAR](300) NULL,
		[Amount] [MONEY] NOT NULL,
		[IsActive] [BIT] NOT NULL,
		[CampaignTypeId] [INT] NOT NULL,	
		[UTCCreatedDateTime] [SMALLDATETIME] NOT NULL,
		[UTCUpdatedDateTime] [SMALLDATETIME] NOT NULL,
	 CONSTRAINT [PK_Campaign] PRIMARY KEY CLUSTERED 
	(
		[CampaignId] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
	 CONSTRAINT [UQ_CampaignCode] UNIQUE NONCLUSTERED 
	(
		[CampaignCode] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]


	ALTER TABLE [Coupon].[Campaign] ADD  CONSTRAINT [DF_Campaign_IsActive]  DEFAULT ((0)) FOR [IsActive]


	ALTER TABLE [Coupon].[Campaign] ADD  CONSTRAINT [DF_CampaignTypeID]  DEFAULT ((1)) FOR [CampaignTypeID]


	ALTER TABLE [Coupon].[Campaign] ADD  CONSTRAINT [DF_CAMPAIGN_UTCCREATEDEDATETIME]  DEFAULT (GETUTCDATE()) FOR [UTCCreatedDateTime]


	ALTER TABLE [Coupon].[Campaign] ADD  CONSTRAINT [DF_CAMPAIGN_UTCUPDATEDDATETIME]  DEFAULT (GETUTCDATE()) FOR [UTCUpdatedDateTime]


	IF OBJECT_ID(N'[Coupon].[Campaign]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [Coupon].[Campaign] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table[Coupon].[Campaign] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [Coupon].[Campaign] already exists.'
	END
GO

--------------- ADD column [UsageTypeID] ------------------------

IF NOT EXISTS(SELECT 1 FROM information_schema.columns      
				WHERE TABLE_SCHEMA      = 'Coupon'
				AND TABLE_NAME			= 'Campaign'
				AND COLUMN_NAME         = 'UsageTypeID') 
BEGIN     
	ALTER TABLE [Coupon].[Campaign] ADD UsageTypeID tinyint  NOT NULL CONSTRAINT DF_UsageTypeID DEFAULT (1)
		PRINT 'Column Coupon.Campaign.UsageTypeID added'
END
ELSE
        PRINT 'Column Coupon.Campaign.UsageTypeID already exists'
GO

--------------- ADD column [IsMutuallyExclusive] ------------------------

IF NOT EXISTS(SELECT 1 FROM information_schema.columns      
				WHERE TABLE_SCHEMA      = 'Coupon'
				AND TABLE_NAME			= 'Campaign'
				AND COLUMN_NAME         = 'IsMutuallyExclusive') 
BEGIN     
	ALTER TABLE [Coupon].[Campaign] ADD IsMutuallyExclusive BIT  NOT NULL CONSTRAINT DF_IsMutuallyExclusive DEFAULT (0)
		PRINT 'Column Coupon.Campaign.IsMutuallyExclusive added'
END
ELSE
        PRINT 'Column Coupon.Campaign.IsMutuallyExclusive already exists'
GO
