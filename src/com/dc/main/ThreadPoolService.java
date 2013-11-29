package com.dc.main;
import java.util.concurrent.ExecutorService;    
import java.util.concurrent.Executors;    
import java.util.concurrent.TimeUnit;    
   
/**   
 * 线程池服务类   
 *    
 * @author DigitalSonic   
 */   
public class ThreadPoolService {    
    /**   
     * 默认线程池大小   
     */   
    public static final int  DEFAULT_POOL_SIZE    = 5;    
   
    /**   
     * 默认一个任务的超时时间，单位为毫秒   
     */   
    public static final long DEFAULT_TASK_TIMEOUT = 1000;    
   
    private int poolSize = DEFAULT_POOL_SIZE;    
    private ExecutorService  executorService;    
   
    /**   
     * 根据给定大小创建线程池   
     */   
    public ThreadPoolService(int poolSize) {    
        setPoolSize(poolSize);    
    }    
   
    /**   
     * 使用线程池中的线程来执行任务   
     */   
    public void execute(Runnable task) {    
        executorService.execute(task);    
    }
    
    public void shutDown() {
    	executorService.shutdown();
    }
   
    /**   
     * 关闭当前ExecutorService   
     *    
     * @param timeout 以毫秒为单位的超时时间   
     */   
    public void destoryExecutorService(long timeout) {    
        if (executorService != null && !executorService.isShutdown()) {    
            try {    
                executorService.awaitTermination(timeout, TimeUnit.MILLISECONDS);    
            } catch (InterruptedException e) {    
                e.printStackTrace();    
            }    
            executorService.shutdown();    
        }    
    }    
   
    /**   
     * 关闭当前ExecutorService，随后根据poolSize创建新的ExecutorService   
     */   
    public void createExecutorService() {    
        destoryExecutorService(1000);    
        executorService = Executors.newFixedThreadPool(poolSize);    
    }  
    
    public boolean isTerminated() {
    	return executorService.isTerminated();
    }
    public boolean isShutdown() {
    	return executorService.isShutdown();
    }
   
    /**   
     * 调整线程池大小   
     * @see #createExecutorService()   
     */   
    public void setPoolSize(int poolSize) {    
        this.poolSize = poolSize;    
        createExecutorService();    
    }    
} 
