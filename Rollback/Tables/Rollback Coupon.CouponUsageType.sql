USE TescoSubscription
GO
/*

	Author:			Robin
	Date created:	17-Feb-2014
	Purpose:		Rollback Table [Coupon].[CouponUsageType]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CouponUsageType]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [Coupon].[CouponUsageType]

		IF OBJECT_ID(N'[Coupon].[CouponUsageType]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [Coupon].[CouponUsageType] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [Coupon].[CouponUsageType] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [Coupon].[CouponUsageType] does not exist.'
	END
GO
