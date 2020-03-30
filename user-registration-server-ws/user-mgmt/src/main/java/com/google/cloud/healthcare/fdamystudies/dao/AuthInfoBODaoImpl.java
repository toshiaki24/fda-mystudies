/*
 * Copyright 2020 Google LLC
 *
 * Use of this source code is governed by an MIT-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/MIT.
 */

package com.google.cloud.healthcare.fdamystudies.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.google.cloud.healthcare.fdamystudies.exceptions.SystemException;
import com.google.cloud.healthcare.fdamystudies.model.AuthInfoBO;
import com.google.cloud.healthcare.fdamystudies.repository.AuthInfoBORepository;
import com.google.cloud.healthcare.fdamystudies.util.AppConstants;

@Service
public class AuthInfoBODaoImpl implements AuthInfoBODao {

  private static final Logger logger = LoggerFactory.getLogger(AuthInfoBODaoImpl.class);
  @Autowired AuthInfoBORepository authInfoRepository;

  @Override
  public AuthInfoBO save(AuthInfoBO authInfo) throws SystemException {
    logger.info("AuthInfoBODaoImpl save() - starts");
    AuthInfoBO dbResponse = null;
    if (authInfo != null) {
      try {
        dbResponse = authInfoRepository.save(authInfo);
        logger.info("AuthInfoBODaoImpl save() - ends");
        return dbResponse;
      } catch (Exception e) {
        logger.error("AuthInfoBODaoImpl save(): ", e);
        throw new SystemException();
      }
    } else return null;
  }

  @Override
  public Map<String, JSONArray> getDeviceTokenOfAllUsers(List<Integer> appIds) {
    logger.info("AuthInfoBODaoImpl.getDeviceTokenOfAllUsers()-Start");
    JSONArray jsonArray = null;
    JSONArray iosJsonArray = null;
    Map<String, JSONArray> deviceMap = new HashMap<>();
    try {
      List<AuthInfoBO> authInfos = authInfoRepository.findDevicesTokens(appIds);
      System.out.println(authInfos);
      if (authInfos != null && !authInfos.isEmpty()) {
        jsonArray = new JSONArray();
        iosJsonArray = new JSONArray();
        for (AuthInfoBO authInfoBO : authInfos) {
          String devicetoken = authInfoBO.getDeviceToken();
          String devicetype = authInfoBO.getDeviceType();
          if (devicetoken != null && devicetype != null) {
            if (devicetype.equalsIgnoreCase(AppConstants.DEVICE_ANDROID)) {
              jsonArray.put(devicetoken.trim());
            } else if (devicetype.equalsIgnoreCase(AppConstants.DEVICE_IOS)) {
              iosJsonArray.put(devicetoken.trim());
            }
          }
        }
        deviceMap.put(AppConstants.DEVICE_ANDROID, jsonArray);
        deviceMap.put(AppConstants.DEVICE_IOS, iosJsonArray);
      }
    } catch (Exception e) {
      logger.info("AuthInfoBODaoImpl.getDeviceTokenOfAllUsers()-error", e);
    }
    logger.info("AuthInfoBODaoImpl.getDeviceTokenOfAllUsers()-end ");
    return deviceMap;
  }
}
