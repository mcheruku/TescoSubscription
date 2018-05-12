/*

	Author:			Manjunathan
	Date created:	01-Oct-2012
	Purpose:		Rollback Procedure [Coupon].[CouponGet]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CouponGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponGet]

		IF OBJECT_ID(N'[Coupon].[CouponGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponGet] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [Coupon].[CouponGet] does not exist.'
	END
GO
