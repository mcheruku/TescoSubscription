USE TescoSubscription
GO
/*

	Author:			Robin
	Date created:	17-Feb-2014
	Purpose:		Rollback Table [Coupon].[CampaignPlanDetails]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CampaignPlanDetails]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [Coupon].[CampaignPlanDetails]

		IF OBJECT_ID(N'[Coupon].[CampaignPlanDetails]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [Coupon].[CampaignPlanDetails] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [Coupon].[CampaignPlanDetails] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [Coupon].[CampaignPlanDetails] does not exist.'
	END
GO
