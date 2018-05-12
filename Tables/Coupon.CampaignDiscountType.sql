USE [TescoSubscription]
GO

/*

	Author:			Robin
	Date created:	14-Jan-2014
	Table Type:		Reference
	Table Size:		Estimated > 100 rows
	Purpose:		Holds reference data for Campaign discount Type
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	

*/
IF OBJECT_ID(N'[Coupon].[CampaignDiscountType]',N'U') IS NULL
	BEGIN
CREATE TABLE [Coupon].[CampaignDiscountType](
	[CampaignID] [bigint] NOT NULL,
	[DiscountTypeID] [tinyint] NOT NULL,
	[DiscountValue] [decimal](6, 2) NOT NULL,
    [UTCCreatedDateTime] [datetime] NOT NULL,
	[UTCUpdatedDateTime] [datetime] NOT NULL,
CONSTRAINT [PK_CampaignDiscountType_CampaignID_DiscountTypeID] PRIMARY KEY CLUSTERED 
(
	[CampaignID] ASC,
	[DiscountTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Coupon].[CampaignDiscountType] ADD  CONSTRAINT [DF_CampaignDiscountType_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]

ALTER TABLE [Coupon].[CampaignDiscountType] ADD  CONSTRAINT [DF_CampaignDiscountType_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

BEGIN
				PRINT 'SUCCESS - Table [Coupon].[CampaignDiscountType] created.'
	 END


		IF OBJECT_ID(N'[Coupon].[CampaignDiscountType]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [Coupon].[CampaignDiscountType] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [Coupon].[CampaignDiscountType] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [Coupon].[CampaignDiscountType] already exists.'
	END
GO


