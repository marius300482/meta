package de.idadachverband.job;

public interface JobCallable<B extends JobBean>
{
    public void call(B jobBean) throws Exception;
}
