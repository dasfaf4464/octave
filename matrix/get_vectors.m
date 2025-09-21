function vectors = get_vectors(mat) %행 벡터를 리스트로 추출하는 함수
  [mat_size_row, mat_size_col] = size(mat); %입력한 행렬의 크기
  vectors = cell(mat_size_row, 1); %행의 개수만큼 셀(배열) 할당

  for i = 1:mat_size_row %1행 부터 n행 까지 배열에 저장
    vectors{i} = mat(i, :); % i행 1열부터 n열 까지 저장
  end
end
