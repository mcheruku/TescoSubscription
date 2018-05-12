/*

	Author:			Swaraj
	Date created:	16-Oct-2012
	Purpose:		Rollback Procedure [Coupon].[CouponDetailsXMLGet]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CouponDetailsXMLGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponDetailsXMLGet]

		IF OBJECT_ID(N'[Coupon].[CouponDetailsXMLGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsXMLGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponDetailsXMLGet] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [Coupon].[CouponDetailsXMLGet] does not exist.'
	END
GO
