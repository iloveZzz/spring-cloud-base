package com.yss.nacos.config.controller;

import com.yss.nacos.config.config.TestConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/config")
public class ConfigController {

    @Autowired
    private TestConfig testConfig;

    @RequestMapping("/get")
    public boolean get() {
        return testConfig.isUseLocalCache();
    }
}