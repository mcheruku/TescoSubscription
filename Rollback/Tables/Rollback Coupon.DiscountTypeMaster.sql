USE TescoSubscription
GO

/*

	Author:			Robin
	Date created:	17-Feb-2014
	Purpose:		Rollback Table [Coupon].[DiscountTypeMaster]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[DiscountTypeMaster]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [Coupon].[DiscountTypeMaster]

		IF OBJECT_ID(N'[Coupon].[DiscountTypeMaster]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [Coupon].[DiscountTypeMaster] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [Coupon].[DiscountTypeMaster] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [Coupon].[DiscountTypeMaster] does not exist.'
	END
GO
