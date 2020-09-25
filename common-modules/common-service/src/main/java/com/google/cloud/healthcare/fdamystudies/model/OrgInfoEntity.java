/*
 * Copyright 2020 Google LLC
 *
 * Use of this source code is governed by an MIT-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/MIT.
 */

package com.google.cloud.healthcare.fdamystudies.model;

import com.google.cloud.healthcare.fdamystudies.common.ColumnConstraints;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;

@Setter
@Getter
@Entity
@Table(name = "org_info")
@ConditionalOnProperty(
    value = "participant.manager.entities.enabled",
    havingValue = "true",
    matchIfMissing = false)
public class OrgInfoEntity implements Serializable {

  private static final long serialVersionUID = 1L;

  @ToString.Exclude
  @Id
  @GeneratedValue(generator = "system-uuid")
  @GenericGenerator(name = "system-uuid", strategy = "uuid")
  @Column(
      name = "org_info_id",
      updatable = false,
      nullable = false,
      length = ColumnConstraints.ID_LENGTH)
  private String id;

  @Column(name = "name", length = ColumnConstraints.SMALL_LENGTH)
  private String name;

  @Column(name = "org_id", nullable = false, unique = true, length = ColumnConstraints.XS_LENGTH)
  private String orgId;

  @Column(
      name = "created_on",
      insertable = false,
      updatable = false,
      columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
  private Timestamp created;

  @Column(name = "created_by", length = ColumnConstraints.LARGE_LENGTH)
  private String createdBy;

  @Column(name = "modified_by", length = ColumnConstraints.LARGE_LENGTH)
  private String modifiedBy;

  @Column(
      name = "modified_date",
      insertable = false,
      updatable = false,
      columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
  private Timestamp modified;

  @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "orgInfo")
  private List<AppEntity> apps = new ArrayList<>();

  public void addAppEntity(AppEntity appEntity) {
    apps.add(appEntity);
    appEntity.setOrgInfo(this);
  }
}