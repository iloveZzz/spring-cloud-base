package com.yss.nacos.config.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;

@Component
@RefreshScope
public class TestConfig {

    @Value("${useLocalCache:false}")
    private boolean useLocalCache;

    public boolean isUseLocalCache() {
        return useLocalCache;
    }

}