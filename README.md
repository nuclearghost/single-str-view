#Sharethrough Single View

In order to better track down the retain cycle of delegates, this simple app, just calls to prefetch ads with a singleton delegate.

If a retain cycle has been created the retain count should be +2, not just +1 for a singleton.
