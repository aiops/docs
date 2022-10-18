# Testing in Production

## Without writing tests

The **Testing in Production (TiP)** paradigm tests new code changes on live user traffic rather than in a staging environment. In contrast, staging or pre-production testing checks code which is not yet available to end users.

Testing in production **improves product reliability**. It provides an enhanced QA strategy since staging environments are rarely identical to production environments. They may have different hardware, firmware, workloads, etc. 

> [!NOTE]
> Shift right is the practice of conducting testing later in the CI/CD pipeline. When taken to the extreme, code is tested in production under real workloads and environmental conditions. 

Since live traffic is being served, it is not adequate to run hand-written tests which can perturbate user experience. There is a need for more advanced **automated and non-intrusive techniques** that require minimal effort from developers. 

`Logsight.ai Continuous Verification` addresses the problem of testing software in production without using hand-written tests. It finds bugs in your services by running instances of your new and old code side by side.

The assumption is that if an OLD Version and NEW Version of a service generate "similar" log messages/files for a subset of user requests, then the two versions behave similarly and the NEW Version can be classified as bug-free. 

<div align=center>
    <img width="700"  src="/stage_verification/imgs/testing_in_production.png"/>
</div>

Logsight uses novel techniques for log abstraction and semantic analysis.
Two versions are judged as "similar" if all log messages seen in the NEW Version (🟢) were already observed in the OLD Version. Unseen messages (🔴) are semantically analysed to determine of they constitute a high risk for the release. If they do, the release is blocked.


## References

- [Anatomy of testing in production: A Netflix original case study](https://conferences.oreilly.com/software-architecture/sa-ny-2019/public/schedule/detail/71337.html) 