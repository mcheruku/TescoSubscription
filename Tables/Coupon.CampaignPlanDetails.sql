USE [TescoSubscription]
GO

/*

	Author:			Robin
	Date created:	14-Jan-2014
	Table Type:		Reference
	Table Size:		Estimated > 100 rows
	Purpose:		Holds data for Campaign Plan Details
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	

*/
IF OBJECT_ID(N'[Coupon].[CampaignPlanDetails]',N'U') IS NULL
	BEGIN

CREATE TABLE [Coupon].[CampaignPlanDetails](
	[CampaignID] [bigint] NOT NULL,
	[SubscriptionPlanID] [int] NOT NULL,
    [UTCCreatedDateTime] [datetime] NOT NULL,
	[UTCUpdatedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_CampaignPlanDetails_CampaignID_SubscriptionPlanID] PRIMARY KEY CLUSTERED 
(
	[CampaignID] ASC,
	[SubscriptionPlanID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [Coupon].[CampaignPlanDetails] ADD  CONSTRAINT [DF_CampaignPlanDetails_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]

ALTER TABLE [Coupon].[CampaignPlanDetails] ADD  CONSTRAINT [DF_CampaignPlanDetails_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

BEGIN
				PRINT 'SUCCESS - Table [Coupon].[CampaignPlanDetails] created.'
	 END


		IF OBJECT_ID(N'[Coupon].[CampaignPlanDetails]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [Coupon].[CampaignPlanDetails] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [Coupon].[CampaignPlanDetails] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [Coupon].[CampaignPlanDetails] already exists.'
	END
GO



