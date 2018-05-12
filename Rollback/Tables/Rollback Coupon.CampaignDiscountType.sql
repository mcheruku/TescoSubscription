USE TescoSubscription
GO

/*

	Author:			Robin
	Date created:	17-Feb-2014
	Purpose:		Rollback Table [Coupon].[CampaignDiscountType]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CampaignDiscountType]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [Coupon].[CampaignDiscountType]

		IF OBJECT_ID(N'[Coupon].[CampaignDiscountType]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [Coupon].[CampaignDiscountType] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [Coupon].[CampaignDiscountType] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [Coupon].[CampaignDiscountType] does not exist.'
	END
GO
