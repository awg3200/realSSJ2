package com.oracle.S202350102.service.jhService;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;

public interface JhCallengeService {

	Challenge jhChgDetail(int chg_id);

	Board jhChgBrdList(int chg_id);



}
