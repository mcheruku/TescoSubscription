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
/*

Author:     Manjunathan Raman
Created:    15 Oct 2012
Purpose:    Create index   [CI_CouponRedemption_CustomerID_CouponCode] on [Coupon].[CouponRedemption]

       --Modifications Hi/*

Author:     Saritha Kommineni
Created:    06 Jan 2012
Purpose:    Create index   [NC_CustomerPaymentHistory_IsEmailSent] on [tescosubscription].[CustomerPaymentHistoryResponse]

       --Modifications History--
Changed On        Changed By        Defect         Change Description

*/

IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponse]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponse]', N'U')
                   AND   [name] = N'NC_CustomerPaymentHistoryResponse_CustomerPaymentHistoryID') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_CustomerPaymentHistoryResponse_CustomerPaymentHistoryID] 
                    ON [tescosubscription].[CustomerPaymentHistoryResponse] ([CustomerPaymentHistoryID] ASC )
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponse]',N'U')
                                 AND   [name] = N'NC_CustomerPaymentHistoryResponse_CustomerPaymentHistoryID') 
                            BEGIN

                                      PRINT 'SUCCESS - Index [NC_CustomerPaymentHistoryResponse_CustomerPaymentHistoryID] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_CustomerPaymentHistoryResponse_CustomerPaymentHistoryID]  not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_CustomerPaymentHistoryResponse_CustomerPaymentHistoryID]  already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerPaymentHistoryResponse] does not exist.',16, 1)
        END

GO
/*

Author:     Saritha Kommineni
Created:    20 Sep 2011
Purpose:    Create index   [NC_CustomerPaymentHistory_CustomerSubscriptionID] on [tescosubscription].[CustomerPaymentHistory]

       --Modifications History--
Changed On        Changed By        Defect         Change Description
25 Aug 2011	      Saritha					        Removed SubscriptionStatus in index	


*/

IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]', N'U')
                   AND   [name] = N'NC_CustomerPaymentHistory_CustomerSubscriptionID') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_CustomerPaymentHistory_CustomerSubscriptionID] 
                    ON [tescosubscription].[CustomerPaymentHistory] ([CustomerSubscriptionID] ASC )
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]',N'U')
                                 AND   [name] = N'NC_CustomerPaymentHistory_CustomerSubscriptionID') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_CustomerPaymentHistory_CustomerSubscriptionID] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_CustomerPaymentHistory_CustomerSubscriptionID] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_CustomerPaymentHistory_CustomerSubscriptionID] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerPaymentHistory] does not exist.',16, 1)
        END

GO
						/*

Author:     Saritha Kommineni
Created:    24 Aug 2011
Purpose:    Create index   [NC_CustomerPaymentHistory_IsEmailSent] on [tescosubscription].[CustomerPaymentHistory]

       --Modifications History--
Changed On        Changed By        Defect         Change Description

*/

IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]', N'U')
                   AND   [name] = N'NC_CustomerPaymentHistory_IsEmailSent') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_CustomerPaymentHistory_IsEmailSent] 
                    ON [tescosubscription].[CustomerPaymentHistory] ([IsEmailSent] ASC )
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]',N'U')
                                 AND   [name] = N'NC_CustomerPaymentHistory_IsEmailSent') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_CustomerPaymentHistory_IsEmailSent] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_CustomerPaymentHistory_IsEmailSent] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_CustomerPaymentHistory_IsEmailSent] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerPaymentHistory] does not exist.',16, 1)
        END

GO
/*

Author:     Saritha Kommineni
Created:    24 Aug 2011
Purpose:    Create index   [NC_CustomerPaymentHistory_PackageExecutionHistoryID] on [tescosubscription].[CustomerPaymentHistory]

       --Modifications History--
Changed On        Changed By        Defect         Change Description
25 Aug 2011	      Saritha					        Removed SubscriptionStatus in index	


*/

IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]', N'U')
                   AND   [name] = N'NC_CustomerPaymentHistory_PackageExecutionHistoryID') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_CustomerPaymentHistory_PackageExecutionHistoryID] 
                    ON [tescosubscription].[CustomerPaymentHistory] ([PackageExecutionHistoryID] ASC)
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]',N'U')
                                 AND   [name] = N'NC_CustomerPaymentHistory_PackageExecutionHistoryID')
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_CustomerPaymentHistory_PackageExecutionHistoryID] created.'
                            END
                       ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_CustomerPaymentHistory_PackageExecutionHistoryID] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_CustomerPaymentHistory_PackageExecutionHistoryID] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerPaymentHistory] does not exist.',16, 1)
        END

GO
/*

Author:     Saritha Kommineni
Created:    20 Sep 2011
Purpose:    Create index   [NC_CustomerPayment_CustomerID] on [tescosubscription].[CustomerPayment]

       --Modifications History--
Changed On        Changed By        Defect         Change Description
25 Aug 2011	      Saritha					        Removed SubscriptionStatus in index	


*/

IF OBJECT_ID(N'[tescosubscription].[CustomerPayment]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPayment]', N'U')
                   AND   [name] = N'NC_CustomerPayment_CustomerID') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_CustomerPayment_CustomerID] 
                    ON [tescosubscription].[CustomerPayment] ([CustomerID] ASC )
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPayment]',N'U')
                                 AND   [name] = N'NC_CustomerPayment_CustomerID') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_CustomerPayment_CustomerID] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_CustomerPayment_CustomerID] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_CustomerPayment_CustomerID] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerPayment] does not exist.',16, 1)
        END

GO
/*

Author:     Robin
Created:    26 May 2014
Purpose:    Create index   [NC_CustomerPayment_PaymentToken] on [tescosubscription].[CustomerPayment]

       --Modifications History--
Changed On        Changed By        Defect         Change Description

*/

IF OBJECT_ID(N'[tescosubscription].[CustomerPayment]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPayment]', N'U')
                   AND   [name] = N'NC_CustomerPayment_PaymentToken') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_CustomerPayment_PaymentToken] 
                    ON [tescosubscription].[CustomerPayment] ([PaymentToken] ASC )
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerPayment]',N'U')
                                 AND   [name] = N'NC_CustomerPayment_PaymentToken') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_CustomerPayment_PaymentToken] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_CustomerPayment_PaymentToken] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_CustomerPayment_PaymentToken] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerPayment] does not exist.',16, 1)
        END

GO
/*

Author:     Saritha Kommineni
Created:    24 Aug 2011
Purpose:    Create index   [NC_CustomerSubscription_CustomerID] on [tescosubscription].[CustomerSubscription]

       --Modifications History--
Changed On        Changed By        Defect         Change Description
25 Aug 2011	      Saritha					        Removed SubscriptionStatus in index	


*/

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]', N'U')
                   AND   [name] = N'NC_CustomerSubscription_CustomerID') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_CustomerSubscription_CustomerID] 
                    ON [tescosubscription].[CustomerSubscription] ([CustomerID] ASC )
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U')
                                 AND   [name] = N'NC_CustomerSubscription_CustomerID') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_CustomerSubscription_CustomerID] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_CustomerSubscription_CustomerID] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_CustomerSubscription_CustomerID] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerSubscription] does not exist.',16, 1)
        END

GO
/*

Author:     Saritha Kommineni
Created:    24 Aug 2011
Purpose:    Create index   [NC_CustomerSubscription_PaymentProcessStatus] on [tescosubscription].[CustomerSubscription]

       --Modifications History--
Changed On        Changed By        Defect         Change Description

*/

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]', N'U')
                   AND   [name] = N'NC_CustomerSubscription_PaymentProcessStatus') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_CustomerSubscription_PaymentProcessStatus] 
                    ON [tescosubscription].[CustomerSubscription] ([PaymentProcessStatus] ASC )
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U')
                                 AND   [name] = N'NC_CustomerSubscription_PaymentProcessStatus') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_CustomerSubscription_PaymentProcessStatus] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_CustomerSubscription_PaymentProcessStatus] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_CustomerSubscription_PaymentProcessStatus] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerSubscription] does not exist.',16, 1)
        END

GO
/*

Author:     Robin John
Created:    27 Jun 2013
Purpose:    Create index   [NC_CustomerSubscription_NextPaymentDate] on [tescosubscription].[CustomerSubscription]

       --Modifications History--
Changed On        Changed By        Defect         Change Description
2 July 2013       Robin					        Removed SubscriptionStatus in index	


*/


IF EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerSubscription', N'U') 
AND [name] = N'NC_CustomerSubscription_SubscriptionStatus_NextPaymentDate')
            BEGIN
                          
                        DROP INDEX tescosubscription.CustomerSubscription.[NC_CustomerSubscription_SubscriptionStatus_NextPaymentDate]


 
                        IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerSubscription', N'U') 
                                                            AND [name] = N'NC_CustomerSubscription_SubscriptionStatus_NextPaymentDate')
                                    BEGIN
                                                PRINT 'SUCCESS - Index [tescosubscription].NC_CustomerSubscription_SubscriptionStatus_NextPaymentDate dropped.'
                                    END
                        ELSE
                                    BEGIN
                                                RAISERROR('FAIL - Index [tescosubscription].NC_CustomerSubscription_SubscriptionStatus_NextPaymentDate not dropped.',16,1)
                                    END
            END


IF OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]', N'U')
                   AND   [name] = N'NC_CustomerSubscription_NextPaymentDate') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_CustomerSubscription_NextPaymentDate] 
                    ON [tescosubscription].[CustomerSubscription] ([NextPaymentDate] ASC)
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U')
                                 AND   [name] = N'NC_CustomerSubscription_NextPaymentDate') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_CustomerSubscription_NextPaymentDate] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_CustomerSubscription_NextPaymentDate] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_CustomerSubscription_NextPaymentDate] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerSubscription] does not exist.',16, 1)
        END

GO
/*

Author:     Saritha Kommineni
Created:    24 Aug 2011
Purpose:    Create index   [NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate] on [tescosubscription].[CustomerSubscription]

       --Modifications History--
Changed On        Changed By        Defect         Change Description
25 Aug 2011	      Saritha					        Removed SubscriptionStatus in index	


*/


IF EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerSubscription', N'U') 
AND [name] = N'NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate')
            BEGIN
                        DROP INDEX tescosubscription.CustomerSubscription.[NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate]
 
                        IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID(N'tescosubscription.CustomerSubscription', N'U') 
                                                            AND [name] = N'NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate')
                                    BEGIN
                                                PRINT 'SUCCESS - Index [tescosubscription].[NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate] dropped.'
                                    END
                        ELSE
                                    BEGIN
                                                RAISERROR('FAIL - Index [tescosubscription].[NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate] not dropped.',16,1)
                                    END
            END
ELSE
            BEGIN
                        PRINT 'NOT EXISTS - Index [tescosubscription].[NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate] does not exist.'
            END
GO


IF OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]', N'U')
                   AND   [name] = N'NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate] 
                    ON [tescosubscription].[CustomerSubscription] ([SubscriptionStatus] ASC ,[NextRenewalDate] ASC)
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U')
                                 AND   [name] = N'NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_CustomerSubscription_SubscriptionStatus_NextRenewalDate] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerSubscription] does not exist.',16, 1)
        END

GO
/*

Author:     Saritha Kommineni
Created:    10 May 2012
Purpose:    Create index   [NC_PackageExecutionHistory_PackageStartTime] on [tescosubscription].[PackageExecutionHistory]

       --Modifications History--
Changed On        Changed By        Defect         Change Description



*/

IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistory]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[PackageExecutionHistory]', N'U')
                   AND   [name] = N'NC_PackageExecutionHistory_PackageStartTime') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_PackageExecutionHistory_PackageStartTime] 
                    ON [tescosubscription].[PackageExecutionHistory] ([PackageStartTime] ASC)
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[PackageExecutionHistory]',N'U')
                                 AND   [name] = N'NC_PackageExecutionHistory_PackageStartTime')
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_PackageExecutionHistory_PackageStartTime] created.'
                            END
                       ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_PackageExecutionHistory_PackageStartTime] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_PackageExecutionHistory_PackageStartTime] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[PackageExecutionHistory] does not exist.',16, 1)
        END

GO
/*

Author:     Saritha Kommineni
Created:    04 Oct 2011
Purpose:    Create index   [NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID] on [tescosubscription].[packageTransactionLog]

       --Modifications History--
Changed On        Changed By        Defect         Change Description


*/

IF OBJECT_ID(N'[tescosubscription].[packageTransactionLog]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[packageTransactionLog]', N'U')
                   AND   [name] = N'NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID] 
                    ON [tescosubscription].[packageTransactionLog] ([PackageExecutionHistoryID] ASC,[TransactionRefrenceID] ASC )
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[packageTransactionLog]',N'U')
                                 AND   [name] = N'NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_packageTransactionLog_PackageExecutionHistoryID_TransactionRefrenceID] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[packageTransactionLog] does not exist.',16, 1)
        END

GO
/*

Author:     Saritha Kommineni
Created:    20 Sep 2011
Purpose:    Create index   [NC_SubscriptionPlan_SortOrder] on [tescosubscription].[SubscriptionPlan]

       --Modifications History--
Changed On        Changed By        Defect         Change Description
25 Aug 2011	      Saritha					        Removed SubscriptionStatus in index	


*/

IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]', N'U')
                   AND   [name] = N'NC_SubscriptionPlan_SortOrder') 
          BEGIN
                    CREATE NONCLUSTERED INDEX [NC_SubscriptionPlan_SortOrder] 
                    ON [tescosubscription].[SubscriptionPlan] ([SortOrder] ASC )
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[SubscriptionPlan]',N'U')
                                 AND   [name] = N'NC_SubscriptionPlan_SortOrder') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [NC_SubscriptionPlan_SortOrder] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [NC_SubscriptionPlan_SortOrder] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [NC_SubscriptionPlan_SortOrder] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[SubscriptionPlan] does not exist.',16, 1)
        END

GO
/*

Author:     Robin 
Created:    7 Jan 2013
Purpose:    Create index   [CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] on [tescosubscription].[CustomerSubscriptionSwitchHistory]

       --Modifications History--
Changed On        Changed By        Defect         Change Description


*/

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistory]',N'U') IS NOT NULL 
BEGIN
   IF NOT EXISTS ( SELECT 1 FROM sys.indexes
                   WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistory]', N'U')
                   AND   [name] = N'CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID') 
          BEGIN
                    CREATE CLUSTERED INDEX [CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] 
                    ON [tescosubscription].[CustomerSubscriptionSwitchHistory] (CustomerSubscriptionID)
                    WITH (ONLINE = ON,FILLFACTOR = 90)

                    IF EXISTS ( SELECT  1 FROM    sys.indexes
                                 WHERE [object_id] = OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistory]',N'U')
                                 AND   [name] = N'CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID') 
                            BEGIN
                                      PRINT 'SUCCESS - Index [CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] created.'
                            END
                    ELSE 
                            BEGIN
                                      RAISERROR ('FAIL - Index [CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] not created.',16, 1 )
                            END
          END
    ELSE 
          BEGIN
                    PRINT 'EXISTS - Index [CI_CustomerSubscriptionSwitchHistory_CustomerSubscriptionID] already exists.'
          END
  END
ELSE 
        BEGIN
              RAISERROR ('FAIL - Table [tescosubscription].[CustomerSubscriptionSwitchHistory] does not exist.',16, 1)
        END

GO
