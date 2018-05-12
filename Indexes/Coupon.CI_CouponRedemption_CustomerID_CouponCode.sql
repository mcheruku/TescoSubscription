/*

Author:     Manjunathan Raman
Created:    15 Oct 2012
Purpose:    Create index   [CI_CouponRedemption_CustomerID_CouponCode] on [Coupon].[CouponRedemption]

       --Modifications History--
Changed On        Changed By        Defect         Change Description
25 Aug 2011	      Saritha					        Removed SubscriptionStatus in index	


*/

IF OBJECT_ID(N'[Coupon].[CouponRedemption]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[Coupon].[CouponRedemption]', N'U')
                   AND   [name] = N'CI_CouponRedemption_CustomerID_CouponCode') 
          BEGIN
                    CREATE CLUSTERED INDEX [CI_CouponRedemption_CustomerID_CouponCode] 
                    ON [Coupon].[CouponRedemption] (CustomerID,couponcode)
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[Coupon].[CouponRedemption]',N'U')
                                 AND   [name] = N'CI_CouponRedemption_CustomerID_CouponCode') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [CI_CouponRedemption_CustomerID_CouponCode] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [CI_CouponRedemption_CustomerID_CouponCode] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [CI_CouponRedemption_CustomerID_CouponCode] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [Coupon].[CouponRedemption] does not exist.',16, 1)
        END

GO
