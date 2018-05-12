/*

	Author:			Manjunathan
	Date created:	01-Oct-2012
	Purpose:		Rollback Procedure [Coupon].[CouponRedemptionSave]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponRedemptionSave]

		IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponRedemptionSave] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponRedemptionSave] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [Coupon].[CouponRedemptionSave] does not exist.'
	END
GO
