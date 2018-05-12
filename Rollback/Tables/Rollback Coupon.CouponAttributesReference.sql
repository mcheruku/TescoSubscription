/*

	Author:			Manjunathan
	Date created:	01-Oct-2012
	Purpose:		Rollback Table [Coupon].[CouponAttributesReference]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CouponAttributesReference]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [Coupon].[CouponAttributesReference]

		IF OBJECT_ID(N'[Coupon].[CouponAttributesReference]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [Coupon].[CouponAttributesReference] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [Coupon].[CouponAttributesReference] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [Coupon].[CouponAttributesReference] does not exist.'
	END
GO
