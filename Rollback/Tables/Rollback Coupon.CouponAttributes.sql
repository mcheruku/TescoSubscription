/*

	Author:			Manjunathan
	Date created:	01-Oct-2012
	Purpose:		Rollback Table [Coupon].[CouponAttributes]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CouponAttributes]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [Coupon].[CouponAttributes]

		IF OBJECT_ID(N'[Coupon].[CouponAttributes]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [Coupon].[CouponAttributes] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [Coupon].[CouponAttributes] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [Coupon].[CouponAttributes] does not exist.'
	END
GO
