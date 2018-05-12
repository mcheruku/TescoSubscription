/*

	Author:			Manjunathan
	Date created:	01-Oct-2012
	Purpose:		Rollback Procedure [Coupon].[CouponUnredemptionSave]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CouponUnredemptionSave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponUnredemptionSave]

		IF OBJECT_ID(N'[Coupon].[CouponUnredemptionSave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponUnredemptionSave] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponUnredemptionSave] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [Coupon].[CouponUnredemptionSave] does not exist.'
	END
GO
